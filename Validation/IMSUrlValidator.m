//
//  IMSUrlValidator.m
//  AussiePsych
//
//  Created by Iain Stubbs on 15/03/12.
//  Copyright (c) 2012 Parallel ThirtyEight South. All rights reserved.
//

#import "IMSUrlValidator.h"
#import "NSString+IMSExtensions.h"

@implementation IMSUrlValidator

NSBundle *messBundle;

-(IMSUrlValidator*)init
{
    self = [super init];
    messBundle = [NSBundle bundleWithPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"IMSValidationMessages.bundle"]];
    return self;
}

- (NSString*) validate:(IMSValidationCheck*)theCheck
{
    theCheck.input = [theCheck.input trimWhitespace];
    if (theCheck.input == nil)
    {
        return @"";
    }
    if ([theCheck.input isEqualToString:@""])
    {
        return @"";
    }
    NSURL *url;
    if (theCheck.password == nil)
    {
        url = [NSURL URLWithString:theCheck.input];        
    }
    else
    {
        NSString* urlString = [theCheck.input createURLwithUsername:theCheck.username andPassword:theCheck.password];
        url = [NSURL URLWithString:urlString];
    }
    if (url == nil)
    {
        if (messBundle)
        {
            return [NSString stringWithFormat:[messBundle localizedStringForKey:@"Url" value:@"Url" table:nil],theCheck.article,theCheck.fieldName];
        }
    }

    return @"";
}

@end

