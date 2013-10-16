//
//  NSStringMask.m
//  NSStringMask
//
//  Created by Flávio Caetano on 4/17/13.
//  Copyright (c) 2013 FlavioCaetano. All rights reserved.
//

#import "NSStringMask.h"

/** Struct for returning multiple values.
 */
typedef struct
{
    NSString *result;
    
    NSInteger length;
} PatternAdaptingResult;

/** Category declaring private ivars and methods for the NSStringMask
 */
@interface NSStringMask ()

@property (nonatomic, strong) NSRegularExpression *regex;

/** Recursive method to format the given string based on the given pattern and character, returning the new regex pattern to be used on NSMutableString's replaceOccurrencesOfString:withString:options:range: and editing the pattern to match this method's replacement string.
 
 @warning This is a recursive method! Its external call must have `i = 1`, `range = (0, string.length)`, `mutableResult = &([NSMutableString new])`:
 
 NSMutableString *formattedString = [NSMutableString new];
 
 NSString *newPattern = [self patternStep:&pattern onString:string iterCount:1 resultFetcher:&formattedString range:NSMakeRange(0, string.length) placeholder:self.placeholder];
 
 @param pattern A pointer to the pattern. It will be edited to replace the first regex group with the matching result based on the iteration i.
 @param string The NSString to be formatted.
 @param i The iteration count. Must start at 1.
 @param mutableResult The filtered string based on the groups matched by pattern.
 @param range The range in which the replacement must start.
 @param placeholder The placeholder to fill missing characters to format the string.
 
 @returns
 */
- (NSString *)patternStep:(NSMutableString **)pattern onString:(NSString *)string iterCount:(long)i resultFetcher:(NSMutableString **)mutableResult range:(NSRange)range placeholder:(NSString *)placeholder;

/** Returns the first regex group and replaces it in the pattern with the current i.
 
 I.e. pattern = @"(\d)-(\w+)", i = 2. On completion, the method will return @"\d" and pattern will be @"$2-(\w+)".
 
 @param pattern A pointer to the pattern. It will be edited to replace the first regex group with the matching result based on the iteration i.
 @param i The current iteration to be placed over the first regex group.
 
 @return The first regex group found in pattern.
 */
- (NSString *)getStepPattern:(NSMutableString **)pattern iter:(long)i;

/** Adjusts the expected repetitions in _group_ to accept variable results from 1 to the maximum accepted subtracting _n_.
 
 Ex: group = "\d{5}", n = 3; result = "\d{1,2}"
 
 @param group A regex pattern.
 @param n The "matched" length to be subtracted.
 
 @return The adapted regex pattern and the maximum length allowed.
 */
- (PatternAdaptingResult)adaptsFirstGroupPattern:(NSString *)group subtracting:(NSUInteger)n;

@end

@implementation NSStringMask

// Initiates the instance with a given pattern.
- (id)initWithPattern:(NSString *)pattern
{
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    self = (error ? nil : [self initWithRegex:regex]);
    return self;
}

// Initiates the instance with a given _pattern_ and _placeholder_.
- (id)initWithPattern:(NSString *)pattern placeholder:(NSString *)placeholder
{
    self = [self initWithPattern:pattern];
    if (self)
    {
        self.placeholder = placeholder;
    }
    return self;
}

// Initiates the instance with a given NSRegularExpression.
- (id)initWithRegex:(NSRegularExpression *)regex
{
    if (regex == nil || regex.numberOfCaptureGroups == 0) return nil;
    
    self = [self init];
    
    if (self)
    {
        self.regex = regex;
        [regex retain];
    }
    
    return self;
}

// Initiates the instance with a given _regex_ and _placeholder_.
- (id)initWithRegex:(NSRegularExpression *)regex placeholder:(NSString *)placeholder
{
    self = [self initWithRegex:regex];
    if (self)
    {
        self.placeholder = placeholder;
    }
    return self;
}

// dealloc
- (void)dealloc
{
    [_regex release], _regex = nil;
    
    [super dealloc];
}

#pragma mark - Class Initializers

// Returns an NSStringMask instance set with the given NSRegularExpression.
+ (id)maskWithRegex:(NSRegularExpression *)regex
{
    return [[[NSStringMask alloc] initWithRegex:regex] autorelease];
}

// Returns an NSStringMask instance set with the given _regex_ and _placeholder_.
+(id)maskWithRegex:(NSRegularExpression *)regex placeholder:(NSString *)placeholder
{
    return [[[NSStringMask alloc] initWithRegex:regex placeholder:placeholder] autorelease];
}

// Returns a NSStringMask instance set with the given pattern.
+ (id)maskWithPattern:(NSString *)pattern
{
    return [[[NSStringMask alloc] initWithPattern:pattern] autorelease];
}

// Returns a NSStringMask instance set with the given _pattern_ and _placeholder_.
+(id)maskWithPattern:(NSString *)pattern placeholder:(NSString *)placeholder
{
    return [[[NSStringMask alloc] initWithPattern:pattern placeholder:placeholder] autorelease];
}

#pragma mark - Class Methods

// Formats a string based on the given regular expression.
+ (NSString *)maskString:(NSString *)string withRegex:(NSRegularExpression *)regex
{
    return [NSStringMask maskString:string withRegex:regex placeholder:nil];
}

// Formats a string based on the given regular expression filling missing characters with the given placeholder.
+ (NSString *)maskString:(NSString *)string withRegex:(NSRegularExpression *)regex placeholder:(NSString *)placeholder
{
    NSStringMask *mask = [NSStringMask maskWithRegex:regex];
    mask.placeholder = placeholder;
    
    return [mask format:string];
}

// Formats a string based on the given regular expression pattern.
+(NSString *)maskString:(NSString *)string withPattern:(NSString *)pattern
{
    return [NSStringMask maskString:string withPattern:pattern placeholder:nil];
}

// Formats a string based on the given regular expression pattern filling missing characters with the given placeholder.
+(NSString *)maskString:(NSString *)string withPattern:(NSString *)pattern placeholder:(NSString *)placeholder
{
    if (! pattern) return nil;
    
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    return [NSStringMask maskString:string withRegex:regex placeholder:placeholder];
}

#pragma mark - Instance Methods

// Formats the given string based on the regex set on the instance.
- (NSString *)format:(NSString *)string
{
    if (string == nil || ! self.regex) return nil;
    
    NSString *validCharacters = [self validCharactersForString:string];
    
    NSMutableString *pattern = [NSMutableString stringWithString:self.regex.pattern];
    NSMutableString *formattedString = [[NSMutableString new] autorelease];
    
    NSString *newPattern = [self patternStep:&pattern onString:validCharacters iterCount:1 resultFetcher:&formattedString range:NSMakeRange(0, validCharacters.length) placeholder:self.placeholder];
    
    // Replacing the occurrences newPattern with the results of pattern on the var formattedString
    [formattedString replaceOccurrencesOfString:newPattern
                                     withString:pattern
                                        options:NSRegularExpressionSearch
                                          range:NSMakeRange(0, formattedString.length)];
    
    return [formattedString copy];
}

// Returns only the valid characters in _string_ that matches the instance's _regex_ limited by the expected length.
- (NSString *)validCharactersForString:(NSString *)string
{
    if (string == nil || ! self.regex) return nil;
    
    NSMutableString *pattern = [NSMutableString stringWithString:self.regex.pattern];
    
    NSError *error = nil;
    
    NSString *firstGroupPattern = [self getStepPattern:&pattern iter:1];
    NSMutableString *validCharacters = [NSMutableString new];
    
    for (int i = 2; firstGroupPattern != nil; i++)
    {
        NSUInteger n = 0;
        PatternAdaptingResult adaptingResult;
        NSTextCheckingResult *result;
        
        do
        {
            // Add a capturing group to the pattern
            adaptingResult = [self adaptsFirstGroupPattern:firstGroupPattern subtracting:n];
            if (adaptingResult.length == 0) break;
            
            firstGroupPattern = adaptingResult.result;
            
            // Try to match the pattern
            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:firstGroupPattern
                                                                                   options:NSRegularExpressionCaseInsensitive
                                                                                     error:&error];
            if (error) NSLog(@"%@", error);
            
            result = [regex firstMatchInString:string options:NSMatchingWithoutAnchoringBounds range:NSMakeRange(0, string.length)];
            if (! result) break;
            
            NSString *matchedString = [string substringWithRange:result.range];
            
            string = [string stringByReplacingCharactersInRange:result.range withString:@""];
            
            [validCharacters appendString:matchedString];
            
            n += result.range.length;
        }
        while (result.range.length != adaptingResult.length);
        
        firstGroupPattern = [self getStepPattern:&pattern iter:i];
    }
    
    return validCharacters;
}

#pragma mark - Properties

// A placeholder to be used to fill an incomplete string.
- (void)setPlaceholder:(NSString *)placeholder
{
    // Empty placeholder (@"")
    if (placeholder != nil && placeholder.length == 0)
    {
        placeholder = nil;
    }
    
    _placeholder = placeholder;
}

#pragma mark - Private Methods

// Adjusts the expected repetitions in _group_ to accept variable results from 0 to the maximum accepted.
- (PatternAdaptingResult)adaptsFirstGroupPattern:(NSString *)group subtracting:(NSUInteger)n
{
    NSError *error = nil;
    
    // Gets the expected maximum repetition for the current group
    NSRegularExpression *maxRepetEx = [NSRegularExpression regularExpressionWithPattern:@"\\{((\\d+)?(?:,(\\d+)?)?)\\}" options:NSMatchingWithoutAnchoringBounds error:&error];
    NSTextCheckingResult *numRep = [maxRepetEx firstMatchInString:group options:NSMatchingWithoutAnchoringBounds range:NSMakeRange(0, group.length)];
    
    // Tries to get the maximum
    NSRange range = [numRep rangeAtIndex:3];
    if (range.location == NSNotFound)
    {
        // Goes for the minimum
        range = [numRep rangeAtIndex:2];
    }
    
    NSInteger numberOfRepetitions = [group substringWithRange:range].integerValue;
    
    // Replaces the the content of braces with {1, numberOfRepetitions}
    if (numberOfRepetitions > 0)
    {
        group = [group stringByReplacingCharactersInRange:[numRep rangeAtIndex:1] withString:[NSString stringWithFormat:@"1,%d", numberOfRepetitions - n]];
    }
    else
    {
        numberOfRepetitions = INFINITY;
    }
    
    PatternAdaptingResult result;
    result.result = group;
    result.length = numberOfRepetitions;
    
    return result;
}

// Recursive method to format the given string based on the given pattern and placeholder, returning the new regex pattern to be used on NSMutableString's replaceOccurrencesOfString:withString:options:range: and editing the pattern to match this method's replacement string.
- (NSString *)patternStep:(NSMutableString **)pattern onString:(NSString *)string iterCount:(long)i resultFetcher:(NSMutableString **)mutableResult range:(NSRange)range placeholder:(NSString *)placeholder
{
    // Get the first group on the pattern and replace it with $i
    NSString *firstGroupPattern = [self getStepPattern:pattern iter:i];
    
    // If there's no group on the pattern, end the recursion.
    if (! firstGroupPattern) return @"";
    
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:firstGroupPattern options:NSMatchingWithoutAnchoringBounds error:&error];
    
    NSTextCheckingResult *result = [regex firstMatchInString:string options:NSMatchingWithoutAnchoringBounds range:range];
    long num = 0;
    
    // If no result, tries the possibility of the string being shorted than expected.
    if ((! result || result.range.location == NSNotFound))
    {
        // Gets the expected repetition for the current group
        NSRegularExpression *numRepetEx = [NSRegularExpression regularExpressionWithPattern:@"\\{(\\d+)?(?:,(\\d+)?)?\\}" options:NSMatchingWithoutAnchoringBounds error:&error];
        NSTextCheckingResult *numRep = [numRepetEx firstMatchInString:firstGroupPattern options:NSMatchingWithoutAnchoringBounds range:NSMakeRange(0, firstGroupPattern.length)];
        NSRange numRange = [numRep rangeAtIndex:2];
        if (numRange.location == NSNotFound)
        {
            numRange = [numRep rangeAtIndex:1];
        }
        
        num = [firstGroupPattern substringWithRange:numRange].integerValue;
        
        // Replaces the expected repetition on the group pattern with "+".
        firstGroupPattern = [firstGroupPattern stringByReplacingCharactersInRange:numRep.range withString:@"+"];
        
        // Tries to match the new pattern on the string.
        regex = [NSRegularExpression regularExpressionWithPattern:firstGroupPattern options:NSMatchingWithoutAnchoringBounds error:&error];
        result = [regex firstMatchInString:string options:NSMatchingWithoutAnchoringBounds range:range];
    }
    
    // The matching on the string
    NSString *stringMatched = [string substringWithRange:result.range];
    [*mutableResult appendString:stringMatched];
    
    if (num > 0 && placeholder)
    {
        // Has a placeholder but couldn't match the expected repetition, but matched when repetition was replaced by "+"
        // Then, it'll complete the missing characters with the placeholder.
        NSString *placeholderRepetition = [@"" stringByPaddingToLength:num-stringMatched.length withString:placeholder startingAtIndex:0];
        [*mutableResult appendString:placeholderRepetition];
        
        // Adjusts the group pattern to also accept the placeholder.
        firstGroupPattern = [NSString stringWithFormat:@"[%@%@]{%ld}", firstGroupPattern, placeholder, num];
    }
    
    if (result)
    {
        // Adjusts the range to advance in the string.
        range.location = result.range.location + result.range.length;
        range.length = string.length - range.location;
    }
    
    return [NSString stringWithFormat:@"(%@)%@", firstGroupPattern, [self patternStep:pattern onString:string iterCount:++i resultFetcher:mutableResult range:range placeholder:placeholder]];
}

// Returns the first regex group and replaces it in the pattern with the current i.
- (NSString *)getStepPattern:(NSMutableString **)pattern iter:(long)i
{
    NSError *error = nil;
    
    // Extracts the content of parentheses if it's not preceded by slash.
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(?<!\\\\)\\(([^)(]*)(?<!\\\\)\\)"
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    NSTextCheckingResult *checkingResult = [regex firstMatchInString:*pattern options:NSMatchingWithoutAnchoringBounds range:NSMakeRange(0, (*pattern).length)];
    if (! checkingResult || checkingResult.range.location == NSNotFound) return nil;
    
    NSString *result = [*pattern substringWithRange:[checkingResult rangeAtIndex:1]];
    
    // Replaces the current group with $i.
    [*pattern replaceCharactersInRange:checkingResult.range withString:[NSString stringWithFormat:@"$%ld", i]];
    
    return result;
}

@end
