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

@property(nonatomic, strong) UIBarButtonItem *keyboardPreviousButton;
@property(nonatomic, strong) UIBarButtonItem *keyboardNextButton;

- (void)moveFocusToElement:(QEntryElement *)control;
@end

@implementation QEntryTableViewCell {
}



- (QEntryElement *)currentEntryElement
{
    return (QEntryElement *)self.currentElement;
}

- (void)createSubviews {
    self.textField = [[QTextField alloc] init];
}

- (void)setTextField:(UITextField *)textField
{
    if (self.textField!=nil){
        [self.textField removeTarget:self action:@selector(textFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
        [self.textField removeFromSuperview];
    }
    _textField = textField;
    self.textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.textField.borderStyle = UITextBorderStyleNone;
    self.textField.delegate = self;
    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.textField.autoresizingMask = ( UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    [self.textField addTarget:self action:@selector(textFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
    self.textField.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.5];
    self.textLabel.backgroundColor = [[UIColor yellowColor] colorWithAlphaComponent:0.5];
    [self.contentView addSubview:self.textField];
}

- (instancetype)initWithReuseIdentifier:(NSString *)string
{
    self = [super initWithReuseIdentifier:string];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createSubviews];
    }
    return self;
}

- (CGRect)calculateFrameForEntryElement {
    NSInteger extra = (self.textField.clearButtonMode == UITextFieldViewModeNever) ? QCellMarginDouble : QCellMargin;

    if (self.currentEntryElement.title == NULL && self.currentEntryElement.image==NULL) {
        return CGRectMake(QCellMarginDouble, QCellMargin, self.contentView.frame.size.width - extra - QCellMarginDouble, self.frame.size.height - QCellMarginDouble);
    }

    if (self.currentEntryElement.title == NULL && self.currentEntryElement.image!=NULL){
        self.imageView.image = self.currentEntryElement.image;
        [self.imageView sizeToFit];
        return CGRectMake(CGRectGetMaxX(self.imageView.frame) + QCellMargin, QCellMargin, self.contentView.frame.size.width - extra - QCellMarginDouble-self.imageView.frame.size.width, self.frame.size.height - QCellMarginDouble);
    }
    CGFloat totalWidth = self.contentView.frame.size.width;
    CGFloat titleWidth = 0;

    if (CGRectEqualToRect(CGRectZero, self.currentEntryElement.parentSection.entryPosition)) {
        for (QElement *el in self.currentEntryElement.parentSection.elements){
            if ([el isKindOfClass:[QEntryElement class]]){
                QEntryElement *q = (QEntryElement*)el; 
                CGFloat imageWidth = q.image == NULL ? 0 : self.imageView.frame.size.width + QCellMargin;
                CGRect rect = [((QEntryElement *) el).title boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)
                                                                         options:NSStringDrawingUsesLineFragmentOrigin
                                                                      attributes:@{ NSFontAttributeName : self.textLabel.font}
                                                                         context:nil];
                titleWidth = rect.size.width + imageWidth;
            }
        }

        self.currentEntryElement.parentSection.entryPosition = CGRectMake(
                titleWidth + QCellMarginDouble + QCellMargin,
                QCellMargin,
                totalWidth - titleWidth - extra - QCellMarginDouble - QCellMargin,
                self.frame.size.height - QCellMarginDouble);
    }

    return self.currentEntryElement.parentSection.entryPosition;
}

- (void)updatePrevNextStatus {
    [self.keyboardPreviousButton setEnabled:[self.currentEntryElement.parentSection.rootElement findElementToFocusOnBefore:self.currentEntryElement]!=nil];
    [self.keyboardNextButton setEnabled:[self.currentEntryElement.parentSection.rootElement findElementToFocusOnAfter:self.currentEntryElement]!=nil];
}

- (void)prepareForElement:(QEntryElement *)element
{
    [self applyAppearanceForElement:element];

    self.textLabel.text = element.title;
    self.labelingPolicy = element.labelingPolicy;

    self.currentEntryElement = element;
    self.textField.text = self.currentEntryElement.textValue;
    self.textField.placeholder = self.currentEntryElement.placeholder;
    if ([self.textField isKindOfClass:[QTextField class]]) {
        QTextField *qtf = (QTextField *) self.textField;
        qtf.prefix = self.currentEntryElement.prefix;
        qtf.suffix = self.currentEntryElement.suffix;
    }

    self.textField.autocapitalizationType = self.currentEntryElement.autocapitalizationType;
    self.textField.autocorrectionType = self.currentEntryElement.autocorrectionType;
    self.textField.keyboardType = self.currentEntryElement.keyboardType;
    self.textField.keyboardAppearance = self.currentEntryElement.keyboardAppearance;
    self.textField.secureTextEntry = self.currentEntryElement.secureTextEntry;
    self.textField.clearsOnBeginEditing = self.currentEntryElement.clearsOnBeginEditing;
    self.textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.textField.textAlignment = self.currentEntryElement.appearance.entryAlignment;

    self.textField.returnKeyType = self.currentEntryElement.returnKeyType;
    self.textField.enablesReturnKeyAutomatically = self.currentEntryElement.enablesReturnKeyAutomatically;

    self.accessoryType = self.currentEntryElement.accessoryType;

    if (self.currentEntryElement.hiddenToolbar){
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
    self.currentEntryElement.parentSection.entryPosition = CGRectZero;
    CGRect textFieldFrame = [self calculateFrameForEntryElement];

    self.textField.frame = textFieldFrame;

    self.textLabel.frame = CGRectMake(QCellMarginDouble, QCellMargin, textFieldFrame.origin.x - QCellMarginDouble - QCellMargin, textFieldFrame.size.height);
    
}

- (void)textFieldEditingChanged:(UITextField *)textFieldEditingChanged {
   self.currentEntryElement.textValue = self.textField.text;
    
    [self.currentEntryElement handleEditingChanged:self];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 50 * USEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.currentEntryElement.currentTableView scrollToRowAtIndexPath:[self.currentEntryElement getIndexPath] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    });


    if (self.textField.returnKeyType == UIReturnKeyDefault) {
        UIReturnKeyType returnType = ([self.currentEntryElement.parentSection.rootElement findElementToFocusOnAfter:self.currentEntryElement]!=nil) ? UIReturnKeyNext : UIReturnKeyDone;
        self.textField.returnKeyType = returnType;
    }

    if(self.currentEntryElement && self.currentEntryElement.delegate && [self.currentEntryElement.delegate respondsToSelector:@selector(QEntryDidBeginEditingElement:andCell:)]){
        [self.currentEntryElement.delegate QEntryDidBeginEditingElement:self.currentEntryElement andCell:self];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.currentEntryElement.textValue = self.textField.text;
    
    if(self.currentEntryElement && self.currentEntryElement.delegate && [self.currentEntryElement.delegate respondsToSelector:@selector(QEntryDidEndEditingElement:andCell:)]){
        [self.currentEntryElement.delegate QEntryDidEndEditingElement:self.currentEntryElement andCell:self];
    }
    
    [self.currentEntryElement performSelector:@selector(fieldDidEndEditing)];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    if (newLength > [textField.text length]) {
        if (0 != self.currentEntryElement.maxLength && textField.text.length >= self.currentEntryElement.maxLength) {
            return NO;
        }
    }

    BOOL shouldChangeCurrent = [self.currentEntryElement.delegate respondsToSelector:@selector(QEntryShouldChangeCharactersInRange:withString:forElement:andCell:)]
            ? [self.currentEntryElement.delegate QEntryShouldChangeCharactersInRange:range withString:string forElement:self.currentEntryElement andCell:self]
            : YES;
    return self.currentEntryElement && self.currentEntryElement.delegate
            && shouldChangeCurrent;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    QEntryElement *element = [self.currentEntryElement.parentSection.rootElement findElementToFocusOnAfter:self.currentEntryElement];
    if (element!=nil){
        UITableViewCell *cell = [self.currentEntryElement.currentTableView cellForElement:element];
        if (cell!=nil){
            [cell becomeFirstResponder];
        }
    }  else {
        [self.textField resignFirstResponder];
    }
    
    if(self.currentEntryElement && self.currentEntryElement.delegate && [self.currentEntryElement.delegate respondsToSelector:@selector(QEntryShouldReturnForElement:andCell:)]){
        return [self.currentEntryElement.delegate QEntryShouldReturnForElement:self.currentEntryElement andCell:self];
    }
    
    return YES;
}

- (void)handleActionBarPrevious
{
    QEntryElement *element = [self.currentEntryElement.parentSection.rootElement findElementToFocusOnBefore:self.currentEntryElement];
    [self moveFocusToElement:element];
}

- (void)handleActionBarNext
{
    QEntryElement *element = [self.currentEntryElement.parentSection.rootElement findElementToFocusOnAfter:self.currentEntryElement];
    [self moveFocusToElement:element];

}

- (void)moveFocusToElement:(QEntryElement *)element {

	if (element != nil) {

        UITableViewCell *cell = [self.currentElement.currentTableView cellForElement:element];
		if (cell != nil) {
			[cell becomeFirstResponder];
		}
        else {

            [self.currentElement.currentTableView scrollToRowAtIndexPath:[element getIndexPath]
                                                        atScrollPosition:UITableViewScrollPositionMiddle
                                                                animated:YES];

            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t) (0.3 * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^{
                UITableViewCell *c = [self.currentElement.currentTableView cellForElement:element];
                if (c != nil) {
                    [c becomeFirstResponder];
                }
            });
        }
	}
    
    if (self.currentEntryElement.keepSelected) {
        [self.currentElement.currentTableView deselectRowAtIndexPath:[self.currentEntryElement getIndexPath] animated:YES];
    }
}

- (BOOL)handleActionBarDone:(UIBarButtonItem *)doneButton {
    [self endEditing:YES];
    [self endEditing:NO];
    [self.textField resignFirstResponder];
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];

    if(self.currentEntryElement && self.currentEntryElement.delegate && [self.currentEntryElement.delegate respondsToSelector:@selector(QEntryMustReturnForElement:andCell:)]){
        [self.currentEntryElement.delegate QEntryMustReturnForElement:self.currentEntryElement andCell:self];
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
    self.textField.textAlignment = appearance.entryAlignment;
    self.textField.font = appearance.entryFont;
    self.textField.textColor = element.enabled ? appearance.entryTextColorEnabled : appearance.entryTextColorDisabled;
}

-(UIToolbar *)createActionBar {
    UIToolbar *actionBar = [[UIToolbar alloc] init];
    [actionBar sizeToFit];

    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Done", @"") style:UIBarButtonItemStyleDone target:self action:@selector(handleActionBarDone:)];

    UIImage *previousImage = [[UIImage imageNamed:@"qd_keyboardPrevious"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImage *nextImage = [[UIImage imageNamed:@"qd_keyboardNext"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

    self.keyboardPreviousButton = [[UIBarButtonItem alloc] initWithImage:previousImage style:UIBarButtonItemStylePlain target:self action:@selector(handleActionBarPrevious)];
    self.keyboardNextButton = [[UIBarButtonItem alloc] initWithImage:nextImage style:UIBarButtonItemStylePlain target:self action:@selector(handleActionBarNext)];

    UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [actionBar setItems:@[self.keyboardPreviousButton, self.keyboardNextButton, flexible, doneButton]];

    return actionBar;
}


@end
