//
//  IMSEntryValidator.m
//  AussiePsych
//
//  Created by Iain Stubbs on 14/03/12.
//  Copyright (c) 2012 Parallel ThirtyEight South. All rights reserved.
//

#import "IMSEntryValidator.h"
#import "IMSValidatorProtocol.h"

@implementation IMSEntryValidator

@synthesize validations;
@synthesize check;
@synthesize checks;
@synthesize groupName;

- (IMSEntryValidator*)initWithValidations:(NSMutableArray*)theValidations andCheck:(IMSValidationCheck*)theCheck
{
    self = [super init];
    
    validations = [[NSMutableArray alloc] init];
    
    for (int i = 0;i<theValidations.count;i++)
    {
        NSObject *val = [theValidations objectAtIndex:i];
        if ([val conformsToProtocol:@protocol(IMSValidatorProtocol)])
        {
            [validations addObject:val];
        }
    }
    check = theCheck;  
    groupName = @"";
    return self;
}

- (IMSEntryValidator*)initWithValidation:(NSObject*)validation andCheck:(IMSValidationCheck*)theCheck
{
    self = [super init];
    
    validations = [[NSMutableArray alloc] init];
    
    if ([validation conformsToProtocol:@protocol(IMSValidatorProtocol)])
    {
        [validations addObject:validation];
    }
    check = theCheck;
    
    return self;
}

- (IMSEntryValidator*)initWithValidation:(NSObject*)validation andChecks:(NSMutableArray*)theChecks
{
    self = [super init];
    
    validations = [[NSMutableArray alloc] init];
    
    if ([validation conformsToProtocol:@protocol(IMSValidatorProtocol)])
    {
        [validations addObject:validation];
    }
    checks = theChecks;
    
    return self;
}

@end
