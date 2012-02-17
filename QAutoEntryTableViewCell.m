// created by Iain Stubbs but based on QEntryTableViewCell.m
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

#import <CoreGraphics/CoreGraphics.h>
#import "DOAutocompleteTextField.h"
#import "QAutoEntryElement.h"

@interface QAutoEntryTableViewCell ()
- (void)handleActionBarPreviousNext:(UISegmentedControl *)control;
- (QAutoEntryElement *)findNextElementToFocusOn;
@end

@implementation QAutoEntryTableViewCell {
    UISegmentedControl *_prevNext;
}
@synthesize txtField = _txtField;
@synthesize autos;

NSString* lastAutoComplete;

- (NSString*)getLastAutoComplete
{
    return lastAutoComplete;
}

- (void)setAutoCompletes:(NSArray*)autoCompletes
{
    autos = autoCompletes;
}

- (void)setAutoCompleteColor:(UIColor*)colour
{
    _txtField.autocompleteTextColor = colour;
}


-(void)createActionBar {
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
    _prevNext.tintColor = [UIColor darkGrayColor];
    [_prevNext addTarget:self action:@selector(handleActionBarPreviousNext:) forControlEvents:UIControlEventValueChanged];
    UIBarButtonItem *prevNextWrapper = [[UIBarButtonItem alloc] initWithCustomView:_prevNext];
    UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [actionBar setItems:[NSArray arrayWithObjects:prevNextWrapper, flexible, doneButton, nil]];
    
	_txtField.inputAccessoryView = actionBar;
}

- (void)createSubviews {
    _txtField = [[DOAutocompleteTextField alloc] init];
    _txtField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _txtField.borderStyle = UITextBorderStyleNone;
    _txtField.delegate = self;
    _txtField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _txtField.autoresizingMask = ( UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    [_txtField addTarget:self action:@selector(textFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.contentView addSubview:_txtField];
    [self setNeedsLayout];
}

- (QAutoEntryTableViewCell *)init {
    self = [self initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"QuickformEntryElement"];
    if (self!=nil){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self createSubviews];
    }
    return self;
}

- (CGRect)calculateFrameForEntryElement {
    if (entryElement.title == NULL) {
        return CGRectMake(10,10,self.contentView.frame.size.width-10, 24);
    }
    CGFloat totalWidth = self.contentView.frame.size.width;
    CGFloat titleWidth = 0;
    
    if (CGRectEqualToRect(CGRectZero, entryElement.parentSection.entryPosition)) {
        for (QElement *el in entryElement.parentSection.elements){
            if ([el isKindOfClass:[QEntryElement class]]){
                CGFloat fontSize = self.textLabel.font.pointSize == 0? 17 : self.textLabel.font.pointSize;
                CGSize size = [((QEntryElement *)el).title sizeWithFont:[self.textLabel.font fontWithSize:fontSize] forWidth:CGFLOAT_MAX lineBreakMode:UILineBreakModeWordWrap] ;
                if (size.width>titleWidth)
                    titleWidth = size.width;
            }
        }
        entryElement.parentSection.entryPosition = CGRectMake(titleWidth+20,10,totalWidth-titleWidth-20,24);
    }
    
    return entryElement.parentSection.entryPosition;
}

- (void)prepareForElement:(QAutoEntryElement *)element inTableView:(QuickDialogTableView *)tableView{
    self.textLabel.text = element.title;
    
    _quickformTableView = tableView;
    entryElement = element;
    txtField.text = entryElement.textValue;
    txtField.placeholder = entryElement.placeholder;
    
    txtField.autocapitalizationType = entryElement.autocapitalizationType;
    txtField.autocorrectionType = entryElement.autocorrectionType;
    txtField.keyboardType = entryElement.keyboardType;
    _txtField.keyboardAppearance = entryElement.keyboardAppearance;
    _txtField.secureTextEntry = entryElement.secureTextEntry;
    
    _txtField.returnKeyType = entryElement.returnKeyType;
    _txtField.enablesReturnKeyAutomatically = entryElement.enablesReturnKeyAutomatically;
    
    if (entryElement.hiddenToolbar){
        _txtField.inputAccessoryView = nil;
    } else {
        [self createActionBar];
    }
    
    [_prevNext setEnabled:[self findPreviousElementToFocusOn]!=nil forSegmentAtIndex:0];
    [_prevNext setEnabled:[self findNextElementToFocusOn]!=nil forSegmentAtIndex:1];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self recalculateEntryFieldPosition];
}


-(void)recalculateEntryFieldPosition {
    entryElement.parentSection.entryPosition = CGRectZero;
    _txtField.frame = [self calculateFrameForEntryElement];
    CGRect labelFrame = self.textLabel.frame;
    self.textLabel.frame = CGRectMake(labelFrame.origin.x, labelFrame.origin.y,
                                      entryElement.parentSection.entryPosition.origin.x-20, labelFrame.size.height);
    
}

- (void)prepareForReuse {
    _quickformTableView = nil;
    entryElement = nil;
}

- (void)textFieldEditingChanged:(DOAutocompleteTextField *)textFieldEditingChanged {
    entryElement.textValue = _txtField.text;
    
    if(entryElement && entryElement.delegate && [entryElement.delegate respondsToSelector:@selector(QEntryEditingChangedForElement:andCell:)]){
        [entryElement.delegate QEntryEditingChangedForElement:entryElement andCell:self];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 50 * USEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [_quickformTableView scrollToRowAtIndexPath:[_quickformTableView indexForElement:entryElement] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    });
    
    
    if (_txtField.returnKeyType == UIReturnKeyDefault) {
        UIReturnKeyType returnType = ([self findNextElementToFocusOn]!=nil) ? UIReturnKeyNext : UIReturnKeyDone;
        _txtField.returnKeyType = returnType;
    }
    
    if(entryElement && entryElement.delegate && [entryElement.delegate respondsToSelector:@selector(QEntryDidBeginEditingElement:andCell:)]){
        [entryElement.delegate QEntryDidBeginEditingElement:entryElement andCell:self];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    entryElement.textValue = _txtField.text;
    
    if(entryElement && entryElement.delegate && [entryElement.delegate respondsToSelector:@selector(QEntryDidEndEditingElement:andCell:)]){
        [entryElement.delegate QEntryDidEndEditingElement:entryElement andCell:self];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if(entryElement && entryElement.delegate && [entryElement.delegate respondsToSelector:@selector(QEntryShouldChangeCharactersInRangeForElement:andCell:)]){
        return [entryElement.delegate QEntryShouldChangeCharactersInRangeForElement:entryElement andCell:self];
    }
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    textField.text = [self getLastAutoComplete];
    
    [textField resignFirstResponder];
    
    QAutoEntryElement *element = [self findNextElementToFocusOn];
    if (element!=nil){
        UITableViewCell *cell = [_quickformTableView cellForElement:element];
        if (cell!=nil){
            [cell becomeFirstResponder];
        }
    }
    
    if(entryElement && entryElement.delegate && [entryElement.delegate respondsToSelector:@selector(QEntryShouldReturnForElement:andCell:)]){
        [entryElement.delegate QEntryShouldReturnForElement:entryElement andCell:self];
    }
    
    return YES;
}

- (void) handleActionBarPreviousNext:(UISegmentedControl *)control {
	QAutoEntryElement *element;
    const BOOL isNext = control.selectedSegmentIndex == 1;
    if (isNext){
		element = [self findNextElementToFocusOn];
	} else {
		element = [self findPreviousElementToFocusOn];
	}
	if (element!=nil){
        UITableViewCell *cell = [_quickformTableView cellForElement:element];
		if (cell!=nil){
			[cell becomeFirstResponder];
		} else {
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 50 * USEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                UITableViewCell *c = [_quickformTableView cellForElement:element];
                if (c!=nil){
                    [c becomeFirstResponder];
                }
            });
        }
	}
}

- (BOOL)handleActionBarDone:(UIBarButtonItem *)doneButton {
    [_txtField resignFirstResponder];
    
    if(entryElement && entryElement.delegate && [entryElement.delegate respondsToSelector:@selector(QEntryMustReturnForElement:andCell:)]){
        [entryElement.delegate QEntryMustReturnForElement:entryElement andCell:self];
    }
    
    return NO;
}

- (BOOL)becomeFirstResponder {
    [_txtField becomeFirstResponder];
    return YES;
}

- (BOOL)resignFirstResponder {
	return YES;
}

- (QAutoEntryElement *)findPreviousElementToFocusOn {
    QAutoEntryElement *previousElement = nil;
    for (QElement * e in entryElement.parentSection.elements){
        if (e == entryElement) {
			return previousElement;
        }
        else if ([e isKindOfClass:[QEntryElement class]]){
            previousElement = (QAutoEntryElement *)e;
        }
    }
    return nil;
}

- (QAutoEntryElement *)findNextElementToFocusOn {
    BOOL foundSelf = NO;
    for (QElement * e in entryElement.parentSection.elements){
        if (e == entryElement) {
            foundSelf = YES;
        }
        else if (foundSelf && [e isKindOfClass:[QAutoEntryElement class]]){
            return (QAutoEntryElement *) e;
        }
    }
    return nil;
}

#pragma mark - DOAutocompleteTextFieldDelegate
- (NSString *)textField:(DOAutocompleteTextField *)textField completionForPrefix:(NSString *)prefix
{
    NSString* lowPrefix = [prefix lowercaseString];
    
    for (NSString *string in autos)
    {
        NSString* strlower = [string lowercaseString];
        if([strlower hasPrefix:lowPrefix])
        {
            NSRange range = NSMakeRange(0,prefix.length);
            lastAutoComplete = string;
            return [string stringByReplacingCharactersInRange:range withString:@""];
        }
    }
    lastAutoComplete = @"";
    return @"";
}

@end