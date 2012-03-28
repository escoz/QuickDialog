//
//  IMSValidation.m
//  AussiePsych
//
//  Created by Iain Stubbs on 14/03/12.
//  Copyright (c) 2012 Parallel ThirtyEight South. All rights reserved.
//

#import "IMSValidation.h"
#import "IMSEntryValidator.h"
#import "Validation.h"
#import "NSMutableArray+IMSExtensions.h"

@implementation IMSValidation

NSString* lastGroup;
NSString* lastResult;

+ (NSString*)processEmailValidator:(NSObject*)val andValidator:(IMSEntryValidator*)ev
{
    IMSEmailValidator *email = (IMSEmailValidator*)val;
    NSString* result = [email validate:ev.check];
    if ([result isEqualToString:@""])
    {
        return @"";
    }
    NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:result,@"\n",nil];
    NSString* ret = [array concatStrings];
    return ret;
}

+ (NSString*)processNullValidator:(NSObject*)val andValidator:(IMSEntryValidator*)ev
{
    IMSNullStringValidator *null = (IMSNullStringValidator*)val;
    NSString* result = [null validate:ev.check];
    if ([result isEqualToString:@""])
    {
        return @"";
    }
    NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:result,@"\n",nil];
    NSString* ret = [array concatStrings];
    return ret;
}

+ (NSString*)processMultiValidator:(NSObject*)val andValidator:(IMSEntryValidator*)ev
{
    IMSMultiStringValidator *multi = (IMSMultiStringValidator*)val; 
    NSString* result = [multi validateChecks:ev.checks];
    if ([result isEqualToString:@""])
    {
        return @"";
    }
    NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:result,@"\n",nil];
    NSString* ret = [array concatStrings];
    return ret;
}

+ (NSString*)processNumericValidator:(NSObject*)val andValidator:(IMSEntryValidator*)ev
{
    IMSNumericValidator *num = (IMSNumericValidator*)val;
    NSString* result = [num validate:ev.check];
    if ([result isEqualToString:@""])
    {
        return @"";
    }
    NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:result,@"\n",nil];
    NSString* ret = [array concatStrings];
    return ret;
}

+ (NSString*)processUrlValidator:(NSObject*)val andValidator:(IMSEntryValidator*)ev
{
    IMSUrlValidator *url = (IMSUrlValidator*)val;
    NSString* result = [url validate:ev.check];
    if ([result isEqualToString:@""])
    {
        return @"";
    }
    NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:result,@"\n",nil];
    NSString* ret = [array concatStrings];
    return ret;
}

+ (NSString*)processAlphabeticValidator:(NSObject*)val andValidator:(IMSEntryValidator*)ev
{
    IMSAlphabeticValidator *alpha = (IMSAlphabeticValidator*)val;
    NSString* result = [alpha validate:ev.check];
    if ([result isEqualToString:@""])
    {
        return @"";
    }
    NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:result,@"\n",nil];
    NSString* ret = [array concatStrings];
    return ret;
}

+ (NSString*)processAlphanumericValidator:(NSObject*)val andValidator:(IMSEntryValidator*)ev
{
    IMSAlphanumericValidator *alpha = (IMSAlphanumericValidator*)val;
    NSString* result = [alpha validate:ev.check];
    if ([result isEqualToString:@""])
    {
        return @"";
    }
    NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:result,@"\n",nil];
    NSString* ret = [array concatStrings];
    return ret;
}

+ (NSString*)processFieldSizeValidator:(NSObject*)val andValidator:(IMSEntryValidator*)ev
{
    IMSFieldSizeValidator *range = (IMSFieldSizeValidator *)val;
    NSString* result = [range validate:ev.check];
    if ([result isEqualToString:@""])
    {
        return @"";
    }
    NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:result,@"\n",nil];
    NSString* ret = [array concatStrings];

    return ret;
}

+ (NSString*)processValidator:(IMSEntryValidator*)validator
{
    NSString* output = @"";
    for (int j = 0; j < validator.validations.count; j++)
    {
        NSObject *val2 = [validator.validations objectAtIndex:j];
        if ([val2 conformsToProtocol:@protocol(IMSValidatorProtocol)])
        {
            if ([val2 isKindOfClass:[IMSEmailValidator class]])
            {
                NSString *res = [self processEmailValidator:val2 andValidator:validator];
                NSMutableArray *out1 = [[NSMutableArray alloc] initWithObjects:output,res,nil];
                output = [out1 concatStrings];
             }   
            else if ([val2 isKindOfClass:[IMSNullStringValidator class]])
            {
                NSString *res = [self processNullValidator:val2 andValidator:validator];
                NSMutableArray *out1 = [[NSMutableArray alloc] initWithObjects:output,res,nil];
                output = [out1 concatStrings];
            }
            else if ([val2 isKindOfClass:[IMSMultiStringValidator class]])
            {
                NSString *res = [self processMultiValidator:val2 andValidator:validator];
                NSMutableArray *out1 = [[NSMutableArray alloc] initWithObjects:output,res,nil];
                output = [out1 concatStrings];
            }
            else if ([val2 isKindOfClass:[IMSUrlValidator class]])
            {
                NSString *res = [self processUrlValidator:val2 andValidator:validator];
                NSMutableArray *out1 = [[NSMutableArray alloc] initWithObjects:output,res,nil];
                output = [out1 concatStrings];
            }
            else if ([val2 isKindOfClass:[IMSNumericValidator class]])
            {
                NSString *res = [self processNumericValidator:val2 andValidator:validator];
                NSMutableArray *out1 = [[NSMutableArray alloc] initWithObjects:output,res,nil];
                output = [out1 concatStrings];
            }
            else if ([val2 isKindOfClass:[IMSAlphabeticValidator class]])
            {
                NSString *res = [self processAlphabeticValidator:val2 andValidator:validator];
                NSMutableArray *out1 = [[NSMutableArray alloc] initWithObjects:output,res,nil];
                output = [out1 concatStrings];
            }
            else if ([val2 isKindOfClass:[IMSAlphanumericValidator class]])
            {
                NSString *res = [self processAlphanumericValidator:val2 andValidator:validator];
                NSMutableArray *out1 = [[NSMutableArray alloc] initWithObjects:output,res,nil];
                output = [out1 concatStrings];
            }
            else if ([val2 isKindOfClass:[IMSFieldSizeValidator class]])
            {
                NSString *res = [self processFieldSizeValidator:val2 andValidator:validator];
                NSMutableArray *out1 = [[NSMutableArray alloc] initWithObjects:output,res,nil];
                output = [out1 concatStrings];
            }
            else
            {
                output = [IMSValidationPlugin processValidator:val2 andValidator:validator];
            }
        }
    }
    return output;
}
+ (NSString*)validate:(NSMutableArray*)validations
{
    NSString *output = @"";
    NSString *result = @"";
    NSString *lastGroup = @"";
    NSString *lastResult = @"";
    
    // first do the exclusive validations
    for (int i = 0; i < validations.count; i++)
    {
        NSObject *val = [validations objectAtIndex:i];
        if ([val isKindOfClass:[IMSEntryValidator class]])
        {
            IMSEntryValidator *ev = (IMSEntryValidator*)val;
            if (![ev.groupName isEqualToString:@""] && [lastGroup isEqualToString:@""])
            {
                result = [self processValidator:ev];
                output = [[[NSMutableArray alloc] initWithObjects:output,result,nil] concatStrings];
                lastResult = result;
                lastGroup = ev.groupName;
            }
            else if (![ev.groupName isEqualToString:@""] && ![lastGroup isEqualToString:ev.groupName])
            {
                result = [self processValidator:ev];
                output = [[[NSMutableArray alloc] initWithObjects:output,result,nil] concatStrings];
                lastResult = result;
                lastGroup = ev.groupName;
            }
            else if (![ev.groupName isEqualToString:@""] && [lastGroup isEqualToString:ev.groupName] && [lastResult isEqualToString:@""])
            {
                result = [self processValidator:ev];
                output = [[[NSMutableArray alloc] initWithObjects:output,result,nil] concatStrings];
                lastResult = result;
                lastGroup = ev.groupName;
            }
            else if (![ev.groupName isEqualToString:@""] && [lastGroup isEqualToString:ev.groupName] && ![lastResult isEqualToString:@""])
            {
                // null action
            }
            else
            {
                result = [self processValidator:ev];
                output = [[[NSMutableArray alloc] initWithObjects:output,result,nil] concatStrings];
                lastResult = result;
                lastGroup = ev.groupName;
            }
        }
    }
    
    return output;
}

+ (NSString*)validateEntries:(NSMutableArray*)validations
{
    NSString *ret = @"";
    lastGroup = @"";
    NSMutableArray *results = [[NSMutableArray alloc] init];
    
    NSString* result = [self validate:validations];
    if (result != nil)
    {
        [results addObject:result];
    }
    if (results.count == 0)
    {
        return nil;
    }
    
    ret = [results concatStrings];
    if ([ret isEqualToString:@""])
    {
        return nil;
    }
    else
    {
        return ret;
    }
}

@end
