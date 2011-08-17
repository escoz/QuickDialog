//
//  Created by escoz on 8/8/11.
//
//  To change this template use File | Settings | File Templates.
//


#import "QEntryTableViewCell.h"
#import "QDecimalTableViewCell.h"
#import "QDecimalElement.h"

@implementation QDecimalTableViewCell {
    NSNumberFormatter *_numberFormatter;
}

- (QDecimalTableViewCell *)init {
    self = [self initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"QuickformDecimalElement"];
    if (self!=nil){
        [self createSubviews];
		self.selectionStyle = UITableViewCellSelectionStyleNone;
        _numberFormatter = [[NSNumberFormatter alloc] init];
        [_numberFormatter setUsesSignificantDigits:YES];
    };
    return self;
}


- (void)createSubviews {
    _textField = [[UITextField alloc] init];
    [_textField addTarget:self action:@selector(textFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
    _textField.borderStyle = UITextBorderStyleNone;
    _textField.keyboardType = UIKeyboardTypeDecimalPad;
    _textField.delegate = self;
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.contentView addSubview:_textField];

    [self setNeedsLayout];
}

- (QDecimalElement *)decimalElement {
    return ((QDecimalElement *)_entryElement);
}

- (void)updateTextFieldFromElement {
    [_numberFormatter setMaximumFractionDigits:[self decimalElement].fractionDigits];
    [_numberFormatter setMinimumFractionDigits:[self decimalElement].fractionDigits]; 
    QDecimalElement *el = (QDecimalElement *)_entryElement;
    _textField.text = [_numberFormatter stringFromNumber:[NSNumber numberWithFloat:el.floatValue]];
}

- (void)prepareForElement:(QEntryElement *)element inTableView:(QuickDialogTableView *)view {
    [super prepareForElement:element inTableView:view];
    _entryElement = element;
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
    [_numberFormatter setMaximumFractionDigits:[self decimalElement].fractionDigits]; 
    [_numberFormatter setMinimumFractionDigits:[self decimalElement].fractionDigits];
    [self decimalElement].floatValue= [[_numberFormatter numberFromString:result] floatValue];
    [self decimalElement].floatValue = (float) (((QDecimalElement *)_entryElement).floatValue / pow(10,[self decimalElement].fractionDigits));
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)replacement {
    NSString *newValue = [_textField.text stringByReplacingCharactersInRange:range withString:replacement];
    [self updateElementFromTextField:newValue];
    [self updateTextFieldFromElement];
    return NO;
}


@end