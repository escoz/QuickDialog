//
//  IMSFixedLengthValidator.m
//  AussiePsych
//
//  Created by Iain Stubbs on 3/04/12.
//  Copyright (c) 2012 Parallel ThirtyEight South. All rights reserved.
//

#import "IMSFixedLengthValidator.h"

@implementation IMSFixedLengthValidator

@synthesize length;

SharedDataSingleton *mSds;

-(IMSFixedLengthValidator *)initWithLength:(NSUInteger)len;
{
    self = [super init];
    length = len;
    mSds = [SharedDataSingleton sharedSingleton];
    return self;
    
}

- (NSString*) validate:(IMSValidationCheck*)theCheck
{
    theCheck.input = [theCheck.input trimWhitespace];
    
    if (theCheck.input.length != length)
    {
        if (mSds.validationBundle)
        {
            return [NSString stringWithFormat:[mSds.validationBundle localizedStringForKey:@"FixedLength" value:@"FixedLength" table:nil],length,theCheck.article,theCheck.fieldName];
        }
    }
    
    return @"";
}


@end
