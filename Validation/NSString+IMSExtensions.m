//
//  NSString+IMSExtensions.m
//  PsychAu
//
//  Created by Iain Stubbs on 30/01/12.
//  Copyright (c) 2012 Parallel ThirtyEight South. All rights reserved.
//

#import "NSString+IMSExtensions.h"

@implementation NSString (IMSExtensions)

- (NSString*)trimWhitespace
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString*)concatMutablerrayIntoString:(NSMutableArray *)strings
{
    return [strings componentsJoinedByString: @""];
}

- (NSString*)concatMutablerrayIntoDelimitedString:(NSMutableArray *)strings delimiter:(NSString*)theDelimiter
{
    return [strings componentsJoinedByString: theDelimiter];
}

- (NSArray*)splitString:(NSString*)theString byDelimiter:(NSString*)theDelimiter
{
    return [theString componentsSeparatedByString:theDelimiter];
}

- (NSString*)createUUID
{
    CFUUIDRef UUID = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef UUIDString = CFUUIDCreateString(kCFAllocatorDefault,UUID);
    return (__bridge NSString*)UUIDString;
}

- (NSString*)createURLwithUsername:(NSString*)username andPassword:(NSString*)password
{
    if (username.length == 0)
    {
        return self;
    }
    
    int end = 0;
    NSMutableString* userpass;
    if ([[self substringWithRange: NSMakeRange (0, 7)] isEqualToString: @"http://"])
    {
        end = 7;
        userpass = [NSMutableString stringWithString:@"http://"];
    }
    else if ([[self substringWithRange: NSMakeRange (0, 8)] isEqualToString: @"https://"])
    {
        end = 8;
        userpass = [NSMutableString stringWithString:@"https://"];
    }
    else
    {
        return self;
    }
    
    [userpass appendString:username];
    [userpass appendString:@":"];
    [userpass appendString:password];
    [userpass appendString:@"@"];
        
    NSMutableString *string1 = [NSMutableString stringWithString:self];
    [string1 replaceCharactersInRange:NSMakeRange(0, end) withString:userpass];

    return [[NSString alloc] initWithString:string1];
}

- (BOOL)holdsFloatingPointValue
{
    return [self holdsFloatingPointValueForLocale:[NSLocale currentLocale]];
}

- (BOOL)holdsFloatingPointValueForLocale:(NSLocale *)locale
{
    NSString *currencySymbol = [locale objectForKey:NSLocaleCurrencySymbol];
    NSString *decimalSeparator = [locale objectForKey:NSLocaleDecimalSeparator];
    NSString *groupingSeparator = [locale objectForKey:NSLocaleGroupingSeparator];
    
    
    // Must be at least one character
    if ([self length] == 0)
        return NO;
    NSString *compare = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    // Strip out grouping separators
    compare = [compare stringByReplacingOccurrencesOfString:groupingSeparator withString:@""];
    
    // We'll allow a single dollar sign in the mix
    if ([compare hasPrefix:currencySymbol])
    {   
        compare = [compare substringFromIndex:1];
        // could be spaces between dollar sign and first digit
        compare = [compare stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    }
    
    NSUInteger numberOfSeparators = 0;
    
    NSCharacterSet *validCharacters = [NSCharacterSet decimalDigitCharacterSet];
    for (NSUInteger i = 0; i < [compare length]; i++) 
    {
        unichar oneChar = [compare characterAtIndex:i];
        if (oneChar == [decimalSeparator characterAtIndex:0])
            numberOfSeparators++;
        else if (![validCharacters characterIsMember:oneChar])
            return NO;
    }
    return (numberOfSeparators == 1);
    
}

- (BOOL)holdsIntegerValue
{
    if ([self length] == 0)
        return NO;
    
    NSString *compare = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSCharacterSet *validCharacters = [NSCharacterSet decimalDigitCharacterSet];
    for (NSUInteger i = 0; i < [compare length]; i++) 
    {
        unichar oneChar = [compare characterAtIndex:i];
        if (![validCharacters characterIsMember:oneChar])
            return NO;
    }
    return YES;
}

-(BOOL)isBlank {
    if([[self stringByStrippingWhitespace] isEqualToString:@""])
        return YES;
    return NO;
}

-(BOOL)contains:(NSString *)string {
    NSRange range = [self rangeOfString:string];
    return (range.location != NSNotFound);
}

-(NSString *)stringByStrippingWhitespace {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

-(NSArray *)splitOnChar:(char)ch {
    NSMutableArray *results = [[NSMutableArray alloc] init];
    int start = 0;
    for(int i=0; i<[self length]; i++) {
        
        BOOL isAtSplitChar = [self characterAtIndex:i] == ch;
        BOOL isAtEnd = i == [self length] - 1;
        
        if(isAtSplitChar || isAtEnd) {
            //take the substring &amp; add it to the array
            NSRange range;
            range.location = start;
            range.length = i - start + 1;
            
            if(isAtSplitChar)
                range.length -= 1;
            
            [results addObject:[self substringWithRange:range]];
            start = i + 1;
        }
        
        //handle the case where the last character was the split char.  we need an empty trailing element in the array.
        if(isAtEnd && isAtSplitChar)
            [results addObject:@""];
    }
    
    return results;
}

-(NSString *)substringFrom:(NSInteger)from to:(NSInteger)to {
    NSString *rightPart = [self substringFromIndex:from];
    return [rightPart substringToIndex:to-from];
}

- (BOOL)isLeadingVowel:(NSString*)input
{
    if ([[input substringToIndex:0] isEqualToString:@"a"] || 
        [[input substringToIndex:0] isEqualToString:@"A"] || 
        [[input substringToIndex:0] isEqualToString:@"e"] || 
        [[input substringToIndex:0] isEqualToString:@"E"] || 
        [[input substringToIndex:0] isEqualToString:@"i"] || 
        [[input substringToIndex:0] isEqualToString:@"I"] || 
        [[input substringToIndex:0] isEqualToString:@"o"] || 
        [[input substringToIndex:0] isEqualToString:@"O"] || 
        [[input substringToIndex:0] isEqualToString:@"U"] || 
        [[input substringToIndex:0] isEqualToString:@"u"] )
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


+ (NSString*) stringWithUUID 
{
    CFUUIDRef	uuidObj = CFUUIDCreate(nil);//create a new UUID
    //get the string representation of the UUID
    NSString	*uuidString = (__bridge_transfer NSString*)CFUUIDCreateString(nil, uuidObj);
    CFRelease(uuidObj);
    return uuidString;
}

@end
