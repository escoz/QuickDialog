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

#import "QEntryTableViewCell.h"
#import "QEntryElement.h"

@interface QEntryTableViewCell ()
- (void)previousNextDelegate:(UISegmentedControl *)control;
- (QEntryElement *)findNextElementToFocusOn;
@end

@implementation QEntryTableViewCell {
    UISegmentedControl *_prevNext;
}
@synthesize textField = _textField;

-(void)createActionBar {
    if (_actionBar == nil) {
        _actionBar = [[UIToolbar alloc] init];
        _actionBar.translucent = YES;
        [_actionBar sizeToFit];
        _actionBar.barStyle = UIBarStyleBlackTranslucent;

        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Done", @"")
                                                                       style:UIBarButtonItemStyleDone target:self
                                                                      action:@selector(textFieldMustReturn:)];

        _prevNext = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:NSLocalizedString(@"Previous", @""), NSLocalizedString(@"Next", @""), nil]];
        _prevNext.momentary = YES;
        _prevNext.segmentedControlStyle = UISegmentedControlStyleBar;
        _prevNext.tintColor = [UIColor darkGrayColor];
        [_prevNext addTarget:self action:@selector(previousNextDelegate:) forControlEvents:UIControlEventValueChanged];
        UIBarButtonItem *prevNextWrapper = [[UIBarButtonItem alloc] initWithCustomView:_prevNext];
        UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        [_actionBar setItems:[NSArray arrayWithObjects:prevNextWrapper, flexible, doneButton, nil]];
	}
	_textField.inputAccessoryView = _actionBar;
}

- (void)createSubviews {
    _textField = [[UITextField alloc] init];
    _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [_textField addTarget:self action:@selector(textFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
    _textField.borderStyle = UITextBorderStyleNone;
    _textField.delegate = self;
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textField.autoresizingMask = ( UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    [self.contentView addSubview:_textField];

    [self setNeedsLayout];
}

- (QEntryTableViewCell *)init {
    self = [self initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"QuickformEntryElement"];
    if (self!=nil){
        [self createSubviews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (CGRect)calculateFrameForEntryElement {
    if (_entryElement.title == NULL) {
        return CGRectMake(10,10,self.contentView.frame.size.width-10, 24);
    }
    CGFloat totalWidth = self.contentView.frame.size.width;
    CGFloat titleWidth = 0;

    if (CGRectEqualToRect(CGRectZero, _entryElement.parentSection.entryPosition)) {
        for (QElement *el in _entryElement.parentSection.elements){
            if ([el isKindOfClass:[QEntryElement class]]){
                CGFloat fontSize = self.textLabel.font.pointSize == 0? 18 : self.textLabel.font.pointSize;
                CGSize size = [((QEntryElement *)el).title sizeWithFont:[self.textLabel.font fontWithSize:fontSize] forWidth:CGFLOAT_MAX lineBreakMode:UILineBreakModeWordWrap] ;
                if (size.width>titleWidth)
                    titleWidth = size.width;
            }
        }

        _entryElement.parentSection.entryPosition = CGRectMake(titleWidth+10,10,totalWidth-titleWidth-10,24);
    }

    return _entryElement.parentSection.entryPosition;
}

- (void)prepareForElement:(QEntryElement *)element inTableView:(QuickDialogTableView *)tableView{
    self.textLabel.text = element.title;

    _quickformTableView = tableView;
    _entryElement = element;
    [self recalculateEntryFieldPosition];
    _textField.text = _entryElement.textValue;
    _textField.placeholder = _entryElement.placeholder;    
    
    _textField.autocapitalizationType = _entryElement.autocapitalizationType;
    _textField.autocorrectionType = _entryElement.autocorrectionType;
    _textField.keyboardType = _entryElement.keyboardType;
    _textField.keyboardAppearance = _entryElement.keyboardAppearance;
    _textField.secureTextEntry = _entryElement.secureTextEntry;
    
    _textField.returnKeyType = _entryElement.returnKeyType;
    _textField.enablesReturnKeyAutomatically = _entryElement.enablesReturnKeyAutomatically;
    
    if (_entryElement.hiddenToolbar){
        _textField.inputAccessoryView = nil;
    } else {
        [self createActionBar];
    }

    [_prevNext setEnabled:[self findPreviousElementToFocusOn]!=nil forSegmentAtIndex:0];
    [_prevNext setEnabled:[self findNextElementToFocusOn]!=nil forSegmentAtIndex:1];
}


-(void)recalculateEntryFieldPosition {
    _entryElement.parentSection.entryPosition = CGRectZero;
   _textField.frame = [self calculateFrameForEntryElement];
}

- (void)prepareForReuse {
    _quickformTableView = nil;
    _entryElement = nil;
}

- (void)textFieldEditingChanged:(UITextField *)textFieldEditingChanged {
   _entryElement.textValue = _textField.text;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (_textField.returnKeyType == UIReturnKeyDefault) {
        UIReturnKeyType returnType = ([self findNextElementToFocusOn]!=nil) ? UIReturnKeyNext : UIReturnKeyDone;
        _textField.returnKeyType = returnType;
    }
    _quickformTableView.selectedCell = self;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (selected==YES){
        [_textField becomeFirstResponder];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    _entryElement.textValue = _textField.text;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [_textField resignFirstResponder];

    QEntryElement *element = [self findNextElementToFocusOn];
    if (element!=nil){
        UITableViewCell *cell = [_quickformTableView cellForElement:element];
        if (cell!=nil){
            [cell becomeFirstResponder];
        }
    }
    return YES;
}

- (void) previousNextDelegate:(UISegmentedControl *)control {
	QEntryElement *element; 
	if (control.selectedSegmentIndex == 1){
		element = [self findNextElementToFocusOn];
      
		
	} else {
		element = [self findPreviousElementToFocusOn];
	}
	if (element!=nil){
		UITableViewCell *cell = [_quickformTableView cellForElement:element];
		if (cell!=nil){
			[cell becomeFirstResponder];
            NSIndexPath *indexPath = [_quickformTableView indexPathForCell: cell];
            [_quickformTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
		}
	}
}


- (BOOL)textFieldMustReturn:(UITextField *)textField {
    [_textField resignFirstResponder];
    return NO;
}

- (BOOL)becomeFirstResponder {
    [_textField becomeFirstResponder];
	return YES;
}

- (BOOL)resignFirstResponder {
    [_textField resignFirstResponder];
	return YES;
}

- (QEntryElement *)findPreviousElementToFocusOn {
    QEntryElement *previousElement = nil;
    for (QElement * e in _entryElement.parentSection.elements){
        if (e == _entryElement) {
			return previousElement;
        }
        else if ([e isKindOfClass:[QEntryElement class]]){
            previousElement = (QEntryElement *)e;
        }
    }
    return nil;
}

- (QEntryElement *)findNextElementToFocusOn {
    BOOL foundSelf = NO;
    for (QElement * e in _entryElement.parentSection.elements){
        if (e == _entryElement) {
           foundSelf = YES;
        }
        else if (foundSelf && [e isKindOfClass:[QEntryElement class]]){
            return (QEntryElement *) e;
        }
    }
    return nil;
}


@end