//
//  IMSFixedLengthValidator.m
//  AussiePsych
//
//  Created by Iain Stubbs on 3/04/12.
//  Copyright (c) 2012 Parallel ThirtyEight South. All rights reserved.
//

#import "IMSFixedLengthValidator.h"
#import "IMSValidationCheck.h"
#import "NSString+IMSExtensions.h"

@implementation IMSFixedLengthValidator

@synthesize length;

NSBundle *messBundle;

-(IMSFixedLengthValidator *)initWithLength:(NSUInteger)len;
{
    self = [super init];
    length = len;
    messBundle = [NSBundle bundleWithPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"IMSValidationMessages.bundle"]];
    return self;
    
}

- (NSString*) validate:(IMSValidationCheck*)theCheck
{
    theCheck.input = [theCheck.input trimWhitespace];
    
    if (theCheck.input.length != length)
    {
        if (messBundle)
        {
            return [NSString stringWithFormat:[messBundle localizedStringForKey:@"FixedLength" value:@"FixedLength" table:nil],length,theCheck.article,theCheck.fieldName];
        }
    }
    
    return @"";
}


@end
