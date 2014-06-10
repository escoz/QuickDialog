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

#import "QDecimalTableViewCell.h"
#import "QDecimalElement.h"

@implementation QDecimalTableViewCell {
    NSNumberFormatter *_numberFormatter;
}

- (instancetype)init {
    self = [self initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"QuickformDecimalElement"];
    if (self!=nil){
        [self createSubviews];
		self.selectionStyle = UITableViewCellSelectionStyleNone;
        _numberFormatter = [[NSNumberFormatter alloc] init];
        [_numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    };
    return self;
}

- (void)createSubviews {
    self.textField = [[QTextField alloc] init];
    //[self.textField addTarget:self action:@selector(textFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
    self.textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.textField.borderStyle = UITextBorderStyleNone;
    self.textField.keyboardType = UIKeyboardTypeDecimalPad;
    self.textField.delegate = self;
    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.textField.autoresizingMask = ( UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    [self.contentView addSubview:self.textField];

    [self setNeedsLayout];
}

- (QDecimalElement *)currentDecimalElement
{
    return ((QDecimalElement *)self.currentEntryElement);
}

- (void)updateTextFieldFromElement {
    [_numberFormatter setMaximumFractionDigits:[self currentDecimalElement].fractionDigits];
    [_numberFormatter setMinimumFractionDigits:[self currentDecimalElement].fractionDigits];
    self.textField.text = [_numberFormatter stringFromNumber:self.currentDecimalElement.numberValue];
}

- (void)prepareForElement:(QEntryElement *)element
{
    [self updateTextFieldFromElement];
}

- (void)updateElementFromTextField:(NSString *)value {
    NSMutableString *result = [[NSMutableString alloc] init];
    for (NSUInteger i = 0; i< [value length]; i++){
        unichar c = [value characterAtIndex:i];
        NSString *charStr = [NSString stringWithCharacters:&c length:1];
        if ([[NSCharacterSet decimalDigitCharacterSet] characterIsMember:c]) {
            [result appendString:charStr];
        }
    }
    [_numberFormatter setMaximumFractionDigits:[self currentDecimalElement].fractionDigits];
    [_numberFormatter setMinimumFractionDigits:[self currentDecimalElement].fractionDigits];
    float parsedValue = [_numberFormatter numberFromString:result].floatValue;
    [self currentDecimalElement].numberValue = @((float) (parsedValue / pow(10, [self currentDecimalElement].fractionDigits)));
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)replacement {
    BOOL shouldChange = YES;
    
    if(self.currentEntryElement && self.currentEntryElement.delegate && [self.currentEntryElement.delegate respondsToSelector:@selector(QEntryShouldChangeCharactersInRange:withString:forElement:andCell:)])
        shouldChange = [self.currentEntryElement.delegate QEntryShouldChangeCharactersInRange:range withString:replacement forElement:self.currentEntryElement andCell:self];
    
    if( shouldChange ) {
        NSString *newValue = [self.textField.text stringByReplacingCharactersInRange:range withString:replacement];
        [self updateElementFromTextField:newValue];
        [self updateTextFieldFromElement];
        [self.currentEntryElement handleEditingChanged:self];
    }
    return NO;
}


@end
