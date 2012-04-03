//
//  IMSEmailValidator.m
//  AussiePsych
//
//  Created by Iain Stubbs on 13/03/12.
//  Copyright (c) 2012 Parallel ThirtyEight South. All rights reserved.
//

#import "IMSEmailValidator.h"
#import "NSString+IMSExtensions.h"

@implementation IMSEmailValidator

NSBundle *messBundle;

-(IMSEmailValidator*)init
{
    self = [super init];
    messBundle = [NSBundle bundleWithPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"IMSValidationMessages.bundle"]];
    return self;
}

- (NSString*) validate:(IMSValidationCheck*)check
{
    check.input = [check.input trimWhitespace];
    if (check.input == nil)
    {
        if (messBundle)
        {
            return [NSString stringWithFormat:[messBundle localizedStringForKey:@"Null" value:@"Null" table:nil],check.article,check.fieldName];
        }
    }

    if ([check.input isEqualToString:@""])
    {
        if (messBundle)
        {
            return [NSString stringWithFormat:[messBundle localizedStringForKey:@"Null" value:@"Null" table:nil],check.article,check.fieldName];
        }        
    }
    else
    {
        NSError *error             = NULL;
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^[+\\w\\.\\-']+@[a-zA-Z0-9-]+(\\.[a-zA-Z]{2,})+$" options:NSRegularExpressionCaseInsensitive error:&error];
        NSUInteger numberOfMatches = [regex numberOfMatchesInString:check.input options:0 range:NSMakeRange(0, check.input.length)];
    
        if (numberOfMatches == 0)
        {        
            if (messBundle)
            {
                return [NSString stringWithFormat:[messBundle localizedStringForKey:@"EmailInvalid" value:@"EmailInvalid" table:nil],check.article,check.fieldName];
            }
        }
    }
    return @"";
}

@end
