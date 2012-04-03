//
//  IMSNullStringValidator.m
//  AussiePsych
//
//  Created by Iain Stubbs on 13/03/12.
//  Copyright (c) 2012 Parallel ThirtyEight South. All rights reserved.
//

#import "IMSNullStringValidator.h"
#import "NSString+IMSExtensions.h"

@implementation IMSNullStringValidator

NSBundle *messBundle;

-(IMSNullStringValidator*)init
{
    self = [super init];
    messBundle = [NSBundle bundleWithPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"IMSValidationMessages.bundle"]];
    return self;
}

- (NSString*) validate:(IMSValidationCheck*)theCheck
{
    if (theCheck.input == nil)
    {
        if (messBundle)
        {
            return [NSString stringWithFormat:[messBundle localizedStringForKey:@"Null" value:@"Null" table:nil],theCheck.article,theCheck.fieldName];
        }
    }
    theCheck.input = [theCheck.input trimWhitespace];
    if ([theCheck.input isEqualToString:@""])
    {
        if (messBundle)
        {
            return [NSString stringWithFormat:[messBundle localizedStringForKey:@"Null" value:@"Null" table:nil],theCheck.article,theCheck.fieldName];
        }
    }
      
    return @"";
}

@end
