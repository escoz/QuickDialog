//
//  IMSMultiStringValidator.m
//  AussiePsych
//
//  Created by Iain Stubbs on 15/03/12.
//  Copyright (c) 2012 Parallel ThirtyEight South. All rights reserved.
//

#import "IMSMultiStringValidator.h"
#import "NSMutableArray+IMSExtensions.h"

NSBundle* messBundle;

@implementation IMSMultiStringValidator

-(IMSMultiStringValidator*)init
{
    self = [super init];
    messBundle = [NSBundle bundleWithPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"IMSValidationMessages.bundle"]];
    return self;
}

- (NSString*) validateChecks:(NSMutableArray*)theChecks
{
    NSMutableArray *validChecks = [[NSMutableArray alloc] init];
    for (int i = 0;i < theChecks.count; i++)
    {
        NSObject *check = [theChecks objectAtIndex:i];
        if ([check isKindOfClass:[IMSValidationCheck class]])
        {
            IMSValidationCheck *val = (IMSValidationCheck*)check;
            [validChecks addObject:val];
        }
    }
    
    if (validChecks.count <= 1)
    {
        return @"";
    }
    
    NSMutableArray *nulls = [[NSMutableArray alloc] init];
    NSMutableArray *somethings = [[NSMutableArray alloc] init];
    // now check if any of the remaining checks are null/blank, and if so - report an error wrt to each of the other ones.
    for (int i = 0; i <validChecks.count; i++)
    {
        IMSValidationCheck* check = [validChecks objectAtIndex:i];
        if (check.input == nil)
        {
            [nulls addObject:check];
        }
        else if ([check.input isEqualToString:@""])
        {
            [nulls addObject:check];            
        }
        else
        {
            [somethings addObject:check];
        }
    }
    
    if (validChecks.count == nulls.count || validChecks.count == somethings.count)
    {
        return @"";
    }
    else
    {
        NSMutableArray* theNulls = [[NSMutableArray alloc] init];
        
        for (int i = 0; i<nulls.count; i++)
        {
            IMSValidationCheck* check = [nulls objectAtIndex:i];
            if (i > 1)
            {
                [theNulls addObject:@" and"];
            }
            [theNulls addObject:@" "];
            [theNulls addObject:check.fieldName];
        }
        
        NSString *nul = [theNulls concatStrings];
        
        NSMutableArray *theSomethings = [[NSMutableArray alloc] init];
        for (int i = 0; i<somethings.count; i++)
        {
            IMSValidationCheck* check = [somethings objectAtIndex:i];
            if (i > 1)
            {
                [theSomethings addObject:@" and"];
            }
            [theSomethings addObject:@" "];
            [theSomethings addObject:check.fieldName];
        }
        NSString *some = [theSomethings concatStrings];
        
         if (messBundle)
        {
            NSString *format = @"";
            if (somethings.count > 1)
            {
                format = [messBundle localizedStringForKey:@"Multi1" value:@"Multi1" table:nil];
            }
            else
            {
                format = [messBundle localizedStringForKey:@"Multi2" value:@"Multi2" table:nil];
            }
            return [NSString stringWithFormat:format,nul,some];

        }

    }
    
    return @"";
}

@end
