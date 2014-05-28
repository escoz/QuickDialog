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
#import "QuickDialog.h"

static const int QCellMarginDouble = 16;
static const int QCellMargin = 8;


@interface QEntryTableViewCell ()
@property(nonatomic, strong) UISegmentedControl *prevNext;


- (void)handleActionBarPreviousNext:(UISegmentedControl *)control;
@end

@implementation QEntryTableViewCell {
}

-(UIToolbar *)createActionBar {
    UIToolbar *actionBar = [[UIToolbar alloc] init];
    [actionBar sizeToFit];

    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Done", @"")
                                                                   style:UIBarButtonItemStyleDone target:self
                                                                  action:@selector(handleActionBarDone:)];

    self.prevNext = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:NSLocalizedString(@"Previous", @""), NSLocalizedString(@"Next", @""), nil]];
    self.prevNext.momentary = YES;
    self.prevNext.tintColor = actionBar.tintColor;
    [self.prevNext addTarget:self action:@selector(handleActionBarPreviousNext:) forControlEvents:UIControlEventValueChanged];
    UIBarButtonItem *prevNextWrapper = [[UIBarButtonItem alloc] initWithCustomView:self.prevNext];
    UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [actionBar setItems:[NSArray arrayWithObjects:prevNextWrapper, flexible, doneButton, nil]];

	return actionBar;
}

- (void)createSubviews {
    self.textField = [[QTextField alloc] init];

    self.contentView.backgroundColor = [UIColor lightGrayColor];
    [self setNeedsLayout];
}

- (void)setTextField:(UITextField *)textField
{
    if (self.textField!=nil){
        [self.textField removeTarget:self action:@selector(textFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
        [self.textField removeFromSuperview];
    }
    _textField = textField;
    self.textField.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
    self.textField.borderStyle = UITextBorderStyleNone;
    self.textField.delegate = self;
    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.textField.autoresizingMask = ( UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    [self.textField addTarget:self action:@selector(textFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
    self.textField.backgroundColor = [UIColor blueColor];
    self.textLabel.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:self.textField];
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
    int extra = (self.textField.clearButtonMode == UITextFieldViewModeNever) ? QCellMarginDouble : QCellMargin;
    if (self.entryElement.title == NULL && self.entryElement.image==NULL) {
        return CGRectMake(QCellMarginDouble, QCellMargin, self.contentView.frame.size.width - extra - QCellMarginDouble, self.frame.size.height - QCellMarginDouble);
    }
    if (self.entryElement.title == NULL && self.entryElement.image!=NULL){
        self.imageView.image = self.entryElement.image;
        [self.imageView sizeToFit];
        return CGRectMake(CGRectGetMaxX(self.imageView.frame) + QCellMargin, + QCellMargin, self.contentView.frame.size.width-10-self.imageView.frame.size.width-extra , self.frame.size.height-20);
    }
    CGFloat totalWidth = self.contentView.frame.size.width;
    CGFloat titleWidth = 0;

    if (CGRectEqualToRect(CGRectZero, self.entryElement.parentSection.entryPosition)) {
        for (QElement *el in self.entryElement.parentSection.elements){
            if ([el isKindOfClass:[QEntryElement class]]){
                QEntryElement *q = (QEntryElement*)el; 
                CGFloat imageWidth = q.image == NULL ? 0 : self.imageView.frame.size.width;
                CGRect rect = [((QEntryElement *) el).title boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:nil context:nil];
                CGFloat width = rect.size.width + imageWidth + 20;
                if (width>titleWidth)
                    titleWidth = width;
            }
        }
        int inset = 0;
        self.entryElement.parentSection.entryPosition = CGRectMake(titleWidth+20,10,totalWidth-titleWidth-self.entryElement.appearance.cellBorderWidth-extra-inset, self.frame.size.height-20);
    }

    return self.entryElement.parentSection.entryPosition;
}

- (void)updatePrevNextStatus {
    [self.prevNext setEnabled:[self.entryElement.parentSection.rootElement findElementToFocusOnBefore:self.entryElement]!=nil forSegmentAtIndex:0];
    [self.prevNext setEnabled:[self.entryElement.parentSection.rootElement findElementToFocusOnAfter:self.entryElement]!=nil forSegmentAtIndex:1];
}

- (void)prepareForElement:(QEntryElement *)element inTableView:(QuickDialogTableView *)tableView{
    [self applyAppearanceForElement:element];

    self.textLabel.text = element.title;
    self.labelingPolicy = element.labelingPolicy;

    self.quickDialogTableView = tableView;
    self.entryElement = element;
    self.textField.text = self.entryElement.textValue;
    self.textField.placeholder = self.entryElement.placeholder;
    if ([self.textField isKindOfClass:[QTextField class]]) {
        QTextField *qtf = (QTextField *) self.textField;
        qtf.prefix = self.entryElement.prefix;
        qtf.suffix = self.entryElement.suffix;
    }

    self.textField.autocapitalizationType = self.entryElement.autocapitalizationType;
    self.textField.autocorrectionType = self.entryElement.autocorrectionType;
    self.textField.keyboardType = self.entryElement.keyboardType;
    self.textField.keyboardAppearance = self.entryElement.keyboardAppearance;
    self.textField.secureTextEntry = self.entryElement.secureTextEntry;
    self.textField.clearsOnBeginEditing = self.entryElement.clearsOnBeginEditing;
    self.textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.textField.textAlignment = self.entryElement.appearance.entryAlignment;

    self.textField.returnKeyType = self.entryElement.returnKeyType;
    self.textField.enablesReturnKeyAutomatically = self.entryElement.enablesReturnKeyAutomatically;

    self.accessoryType = self.entryElement.accessoryType;

    if (self.entryElement.hiddenToolbar){
        self.textField.inputAccessoryView = nil;
    } else if (self.textField!=nil){
        UIToolbar *toolbar = [self createActionBar];
        toolbar.barStyle = element.appearance.toolbarStyle;
        toolbar.translucent = element.appearance.toolbarTranslucent;
        self.textField.inputAccessoryView = toolbar;
    }
    

    [self updatePrevNextStatus];

}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self recalculateEntryFieldPosition];
}


-(void)recalculateEntryFieldPosition {
    self.entryElement.parentSection.entryPosition = CGRectZero;
    CGRect textFieldFrame = [self calculateFrameForEntryElement];
    CGRect labelFrame = self.textLabel.frame;

    self.textField.frame = CGRectMake(textFieldFrame.origin.x, textFieldFrame.origin.y, textFieldFrame.size.width, textFieldFrame.size.height);

    self.textLabel.frame = CGRectMake(labelFrame.origin.x, labelFrame.origin.y,
            textFieldFrame.origin.x  - labelFrame.origin.x, labelFrame.size.height);
    
}

- (void)prepareForReuse {
    self.quickDialogTableView = nil;
    self.entryElement = nil;
}

- (void)textFieldEditingChanged:(UITextField *)textFieldEditingChanged {
   self.entryElement.textValue = self.textField.text;
    
    [self.entryElement handleEditingChanged:self];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 50 * USEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [_quickDialogTableView scrollToRowAtIndexPath:[_entryElement getIndexPath] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    });


    if (self.textField.returnKeyType == UIReturnKeyDefault) {
        UIReturnKeyType returnType = ([self.entryElement.parentSection.rootElement findElementToFocusOnAfter:self.entryElement]!=nil) ? UIReturnKeyNext : UIReturnKeyDone;
        self.textField.returnKeyType = returnType;
    }

    if(self.entryElement && self.entryElement.delegate && [self.entryElement.delegate respondsToSelector:@selector(QEntryDidBeginEditingElement:andCell:)]){
        [self.entryElement.delegate QEntryDidBeginEditingElement:self.entryElement andCell:self];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.entryElement.textValue = self.textField.text;
    
    if(self.entryElement && self.entryElement.delegate && [self.entryElement.delegate respondsToSelector:@selector(QEntryDidEndEditingElement:andCell:)]){
        [self.entryElement.delegate QEntryDidEndEditingElement:self.entryElement andCell:self];
    }
    
    [self.entryElement performSelector:@selector(fieldDidEndEditing)];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    if (newLength > [textField.text length]) {
        if (0 != self.entryElement.maxLength && textField.text.length >= self.entryElement.maxLength) {
            return NO;
        }
    }
    
    if(self.entryElement && self.entryElement.delegate && [self.entryElement.delegate respondsToSelector:@selector(QEntryShouldChangeCharactersInRange:withString:forElement:andCell:)]){
        return [self.entryElement.delegate QEntryShouldChangeCharactersInRange:range withString:string forElement:self.entryElement andCell:self];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    QEntryElement *element = [self.entryElement.parentSection.rootElement findElementToFocusOnAfter:self.entryElement];
    if (element!=nil){
        UITableViewCell *cell = [self.quickDialogTableView cellForElement:element];
        if (cell!=nil){
            [cell becomeFirstResponder];
        }
    }  else {
        [self.textField resignFirstResponder];
    }
    
    if(self.entryElement && self.entryElement.delegate && [self.entryElement.delegate respondsToSelector:@selector(QEntryShouldReturnForElement:andCell:)]){
        return [self.entryElement.delegate QEntryShouldReturnForElement:self.entryElement andCell:self];
    }
    
    return YES;
}

- (void)handleActionBarPreviousNext:(UISegmentedControl *)control {

	QEntryElement *element;

    const BOOL isNext = control.selectedSegmentIndex == 1;
    if (isNext) {
		element = [self.entryElement.parentSection.rootElement findElementToFocusOnAfter:self.entryElement];
	} else {
		element = [self.entryElement.parentSection.rootElement findElementToFocusOnBefore:self.entryElement];
	}

	if (element != nil) {

        UITableViewCell *cell = [self.quickDialogTableView cellForElement:element];
		if (cell != nil) {
			[cell becomeFirstResponder];
		}
        else {

            [self.quickDialogTableView scrollToRowAtIndexPath:[element getIndexPath]
                                             atScrollPosition:UITableViewScrollPositionMiddle
                                                     animated:YES];

            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^{
                UITableViewCell *c = [_quickDialogTableView cellForElement:element];
                if (c != nil) {
                    [c becomeFirstResponder];
                }
            });
        }
	}
    
    if (self.entryElement.keepSelected) {
        [self.quickDialogTableView deselectRowAtIndexPath:[self.entryElement getIndexPath] animated:YES];
    }

    [control setSelectedSegmentIndex:UISegmentedControlNoSegment];
}

- (BOOL)handleActionBarDone:(UIBarButtonItem *)doneButton {
    [self endEditing:YES];
    [self endEditing:NO];
    [self.textField resignFirstResponder];
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];

    if(self.entryElement && self.entryElement.delegate && [self.entryElement.delegate respondsToSelector:@selector(QEntryMustReturnForElement:andCell:)]){
        [self.entryElement.delegate QEntryMustReturnForElement:self.entryElement andCell:self];
    }

    return NO;
}

- (BOOL)becomeFirstResponder {
    [self.textField becomeFirstResponder];
     return YES;
}

- (BOOL)resignFirstResponder {
	return YES;
}


- (void)applyAppearanceForElement:(QElement *)element {
    [super applyAppearanceForElement:element];

    QAppearance *appearance = element.appearance;
    self.textField.font = appearance.entryFont;
    self.textField.textColor = element.enabled ? appearance.entryTextColorEnabled : appearance.entryTextColorDisabled;
}


@end
