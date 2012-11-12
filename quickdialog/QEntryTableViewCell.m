//                                
// Copyright 2011 ESCOZ Inc  - http://escoz.com
// 
// Licensed under the Apache License, Version 2.0 (the "License"); you may not use this 
// file except in compliance with the License. You may obtain a copy of the License at 
// 
// http://www.apache.org/licenses/LICENSE-2.0 
// 
// Unless required by applicable law or agreed to in writing, software distributed under
// the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF 
// ANY KIND, either express or implied. See the License for the specific language governing
// permissions and limitations under the License.
//

@interface QEntryTableViewCell ()
- (void)handleActionBarPreviousNext:(UISegmentedControl *)control;
- (QEntryElement *)findNextElementToFocusOn;
@end

@implementation QEntryTableViewCell {
    UISegmentedControl *_prevNext;
}
@synthesize textField = _textField;

-(UIToolbar *)createActionBar {
    UIToolbar *actionBar = [[UIToolbar alloc] init];
    actionBar.translucent = YES;
    [actionBar sizeToFit];
    actionBar.barStyle = UIBarStyleBlackTranslucent;

    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Done", @"")
                                                                   style:UIBarButtonItemStyleDone target:self
                                                                  action:@selector(handleActionBarDone:)];

    _prevNext = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:NSLocalizedString(@"Previous", @""), NSLocalizedString(@"Next", @""), nil]];
    _prevNext.momentary = YES;
    _prevNext.segmentedControlStyle = UISegmentedControlStyleBar;
    _prevNext.tintColor = actionBar.tintColor;
    [_prevNext addTarget:self action:@selector(handleActionBarPreviousNext:) forControlEvents:UIControlEventValueChanged];
    UIBarButtonItem *prevNextWrapper = [[UIBarButtonItem alloc] initWithCustomView:_prevNext];
    UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [actionBar setItems:[NSArray arrayWithObjects:prevNextWrapper, flexible, doneButton, nil]];

	return actionBar;
}

- (void)createSubviews {
    _textField = [[QTextField alloc] init];
    _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _textField.borderStyle = UITextBorderStyleNone;
    _textField.delegate = self;
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textField.autoresizingMask = ( UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    [_textField addTarget:self action:@selector(textFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.contentView addSubview:_textField];
    [self setNeedsLayout];
}

- (QEntryTableViewCell *)init {
    self = [self initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"QuickformEntryElement"];
    if (self!=nil){
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        [self createSubviews];
    }
    return self;
}

- (CGRect)calculateFrameForEntryElement {
    int extra = (self.textField.clearButtonMode == UITextFieldViewModeNever) ? 15 :10;
    if (_entryElement.title == NULL && _entryElement.image==NULL) {
        return CGRectMake(10,10,self.contentView.frame.size.width-10-extra, self.frame.size.height-20);
    }
    if (_entryElement.title == NULL && _entryElement.image!=NULL){
        return CGRectMake( _entryElement.image.size.width, 10, self.contentView.frame.size.width-10-_entryElement.image.size.width-extra , self.frame.size.height-20);
    }
    CGFloat totalWidth = self.contentView.frame.size.width;
    CGFloat titleWidth = 0;

    if (CGRectEqualToRect(CGRectZero, _entryElement.parentSection.entryPosition)) {
        for (QElement *el in _entryElement.parentSection.elements){
            if ([el isKindOfClass:[QEntryElement class]]){
                QEntryElement *q = (QEntryElement*)el; 
                CGFloat imageWidth = q.image == NULL ? 0 : q.image.size.width + 10;  
                CGFloat fontSize = self.textLabel.font.pointSize == 0? 17 : self.textLabel.font.pointSize;
                CGSize size = [((QEntryElement *)el).title sizeWithFont:[self.textLabel.font fontWithSize:fontSize] forWidth:CGFLOAT_MAX lineBreakMode:UILineBreakModeWordWrap] ;
                CGFloat width = size.width + imageWidth;
                if (width>titleWidth)
                    titleWidth = width;
            }
        }
        _entryElement.parentSection.entryPosition = CGRectMake(titleWidth+20,10,totalWidth-titleWidth-20-extra, self.frame.size.height-20);
    }

    return _entryElement.parentSection.entryPosition;
}

- (void)updatePrevNextStatus {
    [_prevNext setEnabled:[self findPreviousElementToFocusOn]!=nil forSegmentAtIndex:0];
    [_prevNext setEnabled:[self findNextElementToFocusOn]!=nil forSegmentAtIndex:1];
}

- (void)prepareForElement:(QEntryElement *)element inTableView:(QuickDialogTableView *)tableView{
    self.textLabel.text = element.title;

    _quickformTableView = tableView;
    _entryElement = element;
    _textField.text = _entryElement.textValue;
    _textField.placeholder = _entryElement.placeholder;
    _textField.prefix = _entryElement.prefix;
    _textField.suffix = _entryElement.suffix;

    _textField.autocapitalizationType = _entryElement.autocapitalizationType;
    _textField.autocorrectionType = _entryElement.autocorrectionType;
    _textField.keyboardType = _entryElement.keyboardType;
    _textField.keyboardAppearance = _entryElement.keyboardAppearance;
    _textField.secureTextEntry = _entryElement.secureTextEntry;
    _textField.clearsOnBeginEditing = _entryElement.clearsOnBeginEditing;
    
    _textField.returnKeyType = _entryElement.returnKeyType;
    _textField.enablesReturnKeyAutomatically = _entryElement.enablesReturnKeyAutomatically;

    self.accessoryType = _entryElement.accessoryType;

    if (_entryElement.hiddenToolbar){
        _textField.inputAccessoryView = nil;
    } else {
        _textField.inputAccessoryView = [self createActionBar];
    }

    [self updatePrevNextStatus];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self recalculateEntryFieldPosition];
}


-(void)recalculateEntryFieldPosition {
    _entryElement.parentSection.entryPosition = CGRectZero;
    _textField.frame = [self calculateFrameForEntryElement];
    CGRect labelFrame = self.textLabel.frame;
    self.textLabel.frame = CGRectMake(labelFrame.origin.x, labelFrame.origin.y,
            _entryElement.parentSection.entryPosition.origin.x-20, labelFrame.size.height);
    
}

- (void)prepareForReuse {
    _quickformTableView = nil;
    _entryElement = nil;
    _textField.textAlignment = UITextAlignmentLeft;
}

- (void)textFieldEditingChanged:(UITextField *)textFieldEditingChanged {
   _entryElement.textValue = _textField.text;
    
    if(_entryElement && _entryElement.delegate && [_entryElement.delegate respondsToSelector:@selector(QEntryEditingChangedForElement:andCell:)]){
        [_entryElement.delegate QEntryEditingChangedForElement:_entryElement andCell:self];
    }
    
    if(_entryElement.onValueChanged) {
        _entryElement.onValueChanged();
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 50 * USEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [_quickformTableView scrollToRowAtIndexPath:[_quickformTableView indexForElement:_entryElement] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    });


    if (_textField.returnKeyType == UIReturnKeyDefault) {
        UIReturnKeyType returnType = ([self findNextElementToFocusOn]!=nil) ? UIReturnKeyNext : UIReturnKeyDone;
        _textField.returnKeyType = returnType;
    }

    if(_entryElement && _entryElement.delegate && [_entryElement.delegate respondsToSelector:@selector(QEntryDidBeginEditingElement:andCell:)]){
        [_entryElement.delegate QEntryDidBeginEditingElement:_entryElement andCell:self];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    _entryElement.textValue = _textField.text;
    
    if(_entryElement && _entryElement.delegate && [_entryElement.delegate respondsToSelector:@selector(QEntryDidEndEditingElement:andCell:)]){
        [_entryElement.delegate QEntryDidEndEditingElement:_entryElement andCell:self];
    }
    
    [_entryElement performSelector:@selector(fieldDidEndEditing)];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if(_entryElement && _entryElement.delegate && [_entryElement.delegate respondsToSelector:@selector(QEntryShouldChangeCharactersInRangeForElement:andCell:)]){
        return [_entryElement.delegate QEntryShouldChangeCharactersInRangeForElement:_entryElement andCell:self];
    }
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    QEntryElement *element = [self findNextElementToFocusOn];
    if (element!=nil){
        UITableViewCell *cell = [_quickformTableView cellForElement:element];
        if (cell!=nil){
            [cell becomeFirstResponder];
        }
    }  else {
        [_textField resignFirstResponder];
    }
    
    if(_entryElement && _entryElement.delegate && [_entryElement.delegate respondsToSelector:@selector(QEntryShouldReturnForElement:andCell:)]){
        return [_entryElement.delegate QEntryShouldReturnForElement:_entryElement andCell:self];
    }
    
    return YES;
}

- (void)handleActionBarPreviousNext:(UISegmentedControl *)control {

	QEntryElement *element;

    const BOOL isNext = control.selectedSegmentIndex == 1;
    if (isNext) {
		element = [self findNextElementToFocusOn];
	} else {
		element = [self findPreviousElementToFocusOn];
	}

	if (element != nil) {

        UITableViewCell *cell = [_quickformTableView cellForElement:element];
		if (cell != nil) {
			[cell becomeFirstResponder];
		}
        else {

            [_quickformTableView scrollToRowAtIndexPath:[_quickformTableView indexForElement:element]
                                       atScrollPosition:UITableViewScrollPositionMiddle
                                               animated:YES];

            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^{
                UITableViewCell *c = [_quickformTableView cellForElement:element];
                if (c != nil) {
                    [c becomeFirstResponder];
                }
            });
        }
	}
}

- (BOOL)handleActionBarDone:(UIBarButtonItem *)doneButton {
    [self endEditing:YES];
    [self endEditing:NO];
    [_textField resignFirstResponder];

    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];

    if(_entryElement && _entryElement.delegate && [_entryElement.delegate respondsToSelector:@selector(QEntryMustReturnForElement:andCell:)]){
        [_entryElement.delegate QEntryMustReturnForElement:_entryElement andCell:self];
    }

    return NO;
}

- (BOOL)becomeFirstResponder {
    [_textField becomeFirstResponder];
     return YES;
}

- (BOOL)resignFirstResponder {
	return YES;
}

- (QEntryElement *)findPreviousElementToFocusOn {

    QEntryElement *previousElement = nil;
    for (QSection *section in _entryElement.parentSection.rootElement.sections) {
        for (QElement *e in section.elements) {
            if (e == _entryElement) {
                return previousElement;
            }
            else if ([e isKindOfClass:[QEntryElement class]] && [(QEntryElement *)e canTakeFocus]) {
                previousElement = (QEntryElement *)e;
            }
        }
    }
    return nil;
}

- (QEntryElement *)findNextElementToFocusOn {

    BOOL foundSelf = NO;
    for (QSection *section in _entryElement.parentSection.rootElement.sections) {
        for (QElement *e in section.elements) {
            if (e == _entryElement) {
                foundSelf = YES;
            }
            else if (foundSelf && [e isKindOfClass:[QEntryElement class]] && [(QEntryElement *)e canTakeFocus]) {
                return (QEntryElement *) e;
            }
        }
    }
    return nil;
}


@end