//
//  QEntryValidator.m
//  QuickDialog
//
//  Created by Ken Cooper on 2/9/12.
//  Copyright (c) 2012 Coopercode, LLC. All rights reserved.
//

#import "QEntryValidator.h"

@implementation QEntryValidator

@synthesize regexPattern=_regexPattern;
@synthesize regexFailedText=_regexFailedText;
@synthesize requiredFieldText=_requiredFieldText;

+(QEntryValidator *)emailField: (NSString *)errorText
{
    QEntryValidator *validator = [[QEntryValidator alloc]init];
    validator.regexPattern = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    validator.regexFailedText = errorText;
    return validator;
}

+(QEntryValidator *)requiredField: (NSString *)errorText
{
    QEntryValidator *validator = [[QEntryValidator alloc]init];
    validator.requiredFieldText = errorText;
    return validator;
}

-(NSString *)validate: (QRootElement *)element
{
    QEntryElement *entry = (QEntryElement *)element;
    
    NSString *trimmed = [entry.textValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (_requiredFieldText &&  trimmed.length == 0) {
        return _requiredFieldText;
    }
    
    if (_regexPattern) {
        NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", _regexPattern];
        if (![test evaluateWithObject: trimmed]) {
            return _regexFailedText;
        }
    }
    
    return nil;
}
@end
