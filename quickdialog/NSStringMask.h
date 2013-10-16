//
//  NSStringMask.h
//  NSStringMask
//
//  Created by Flávio Caetano on 4/17/13.
//  Copyright (c) 2013 FlavioCaetano. All rights reserved.
//
//  Alo alo bla bla.
//
//  Lorem ipsum dolor sit amet
//

#import <Foundation/Foundation.h>

/** [![NSStringMask Version](http://cocoapod-badges.herokuapp.com/v/NSStringMask/badge.png)](http://cocoadocs.org/docsets/NSStringMask) [![NSStringMask Platforms](http://cocoapod-badges.herokuapp.com/p/NSStringMask/badge.svg)](http://cocoadocs.org/docsets/NSStringMask) [![Build Status](https://travis-ci.org/fjcaetano/NSStringMask.png)](https://travis-ci.org/fjcaetano/NSStringMask)
 
 The NSStringMask enables you to apply _masks_ or _formats_ to NSStrings using NSRegularExpression to input your format.
 
 Suppose you want to format a Social Security Number "12345678", its regex is "(\\d{3})-(\\d{2})-(\\d{3})". You can easily format it using:
 
    NStringMask maskString:@"12345678" withPattern:@"(\\d{3})-(\\d{2})-(\\d{3})"];
 
    // result: "123-45-678"
 
 @note In [this link](https://gist.github.com/fjcaetano/5600452) you'll find a list with some common patterns. Feel free to improve it!
 
 @warning When passing a pattern or regex, at least one capturing parentheses `[group]` must be informed. This is because NSStringMask will only format the expressions within groups.  This way, if you have a pattern "`\d`" the formatting won't replace any numbers because in its understanding, that's part of the mask, and not a "replacing regex".
 
 @warning Always remember to use double slashes to escape the pattern's special characters!
 */
@interface NSStringMask : NSObject

/// @name Properties

/** A placeholder to be used to fill voids in an incomplete string.
 
 Can be nil, but not empty. If an empty placeholder is given, it's assumed as nil. The placeholder will repeat for each capturing parentheses `[group]` in the regex, so, if the placeholder is a long string, it'll restart the filling for each group.
 
 No formatting is done when _placeholder_ is nil and the passed string is shorter than expected. In this case, the formatting will returned a clean string without unexpected characters.
 
 Results for _placeholder_ on formatting the string "0X" with pattern "`(\d{3})-(\d{1})`":
 
 - "\_" -> result = "0\_\_-\_"
 - "abcde" -> result = "0ab-a"
 - nil -> result = "0"
 - "" -> result = "0" `// same as above`
 
 */
@property (nonatomic, retain) NSString *placeholder;

#pragma mark - inits
/// @name inits

/** Returns an NSStringMask instance set with the given _regex_.
 
 @warning If _regex_ doesn't have at least one capturing parentheses `[group]` it's considered invalid and the method returns nil.
 
 @param regex A given regular expression. If nil, no instance is created.
 
 @return An instance or nil if regex is invalid.
 */
+ (id)maskWithRegex:(NSRegularExpression *)regex;

/** Returns an NSStringMask instance set with the given _regex_ and _placeholder_.
 
 @warning If _regex_ doesn't have at least one capturing parentheses `[group]` it's considered invalid and the method returns nil.
 
 @param regex A given regular expression. If nil, no instance is created.
 @param placeholder The placeholder string to fill the voids.
 
 @return An instance or nil if regex is invalid.
 */
+ (id)maskWithRegex:(NSRegularExpression *)regex placeholder:(NSString *)placeholder;

/** Initiates the instance with a given _regex_.
 
 @warning If _regex_ doesn't have at least one capturing parentheses `[group]` it's considered invalid and the method returns nil.
 
 @param regex A given regular expression. If nil, no instance is created.
 
 @return An instance or nil if regex is invalid.
 */
- (id)initWithRegex:(NSRegularExpression *)regex;

/** Initiates the instance with a given _regex_ and _placeholder_.
 
 @warning If _regex_ doesn't have at least one capturing parentheses `[group]` it's considered invalid and the method returns nil.
 
 @param regex A given regular expression. If nil, no instance is created.
 @param placeholder The placeholder string to fill the voids.
 
 @return An instance or nil if regex is invalid.
 */
- (id)initWithRegex:(NSRegularExpression *)regex placeholder:(NSString *)placeholder;

/** Returns a NSStringMask instance set with the given _pattern_.
 
 A NSRegularExpression is created based on the _pattern_ passed.
 
 @warning If _pattern_ doesn't have at least one capturing parentheses `[group]` it's considered invalid and the method returns nil.
 
 @param pattern A given regular expression pattern. If invalid, no instance is created.
 
 @return An instance or nil if pattern is invalid.
 */
+ (id)maskWithPattern:(NSString *)pattern;

/** Returns a NSStringMask instance set with the given _pattern_ and _placeholder_.
 
 A NSRegularExpression is created based on the _pattern_ passed.
 
 @warning If _pattern_ doesn't have at least one capturing parentheses `[group]` it's considered invalid and the method returns nil.
 
 @param pattern A given regular expression pattern. If invalid, no instance is created.
 @param placeholder The placeholder string to fill the voids.
 
 @return An instance or nil if pattern is invalid.
 */
+ (id)maskWithPattern:(NSString *)pattern placeholder:(NSString *)placeholder;

/** Initiates the instance with a given _pattern_.
 
 A NSRegularExpression is created based on the _pattern_ passed.
 
 @warning If _pattern_ doesn't have at least one capturing parentheses `[group]` it's considered invalid and the method returns nil.
 
 @param pattern A given regular expression pattern. If invalid, no instance is created.
 
 @return An instance or nil if pattern is invalid.
 */
- (id)initWithPattern:(NSString *)pattern;

/** Initiates the instance with a given _pattern_ and _placeholder_.
 
 A NSRegularExpression is created based on the _pattern_ passed.
 
 @warning If _pattern_ doesn't have at least one capturing parentheses `[group]` it's considered invalid and the method returns nil.
 
 @param pattern A given regular expression pattern. If invalid, no instance is created.
 @param placeholder The placeholder string to fill the voids.
 
 @return An instance or nil if pattern is invalid.
 */
- (id)initWithPattern:(NSString *)pattern placeholder:(NSString *)placeholder;

#pragma mark - Class Methods
/// @name Class Methods

/** Formats _string_ based on the given _regex_.
 
 If _string_ is shorter than expected, the method returns a cleaned NSString based on _regex_`s groups, but without format:
 
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(\\d).(\\d{4})"
    options:NSRegularExpressionCaseInsensitive
    error:&error];
 
    [NSStringMask maskString:@"123abcd" withRegex:regex];
    // result: "123"
 
 This is because _regex_ is expecting 5 "formattable" numbers but only 3 are being passed. So it doesn't know how to handle it.
 
 If _string_ is longer than expected, the method returns a formatted NSString until the expected length:
 
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(\\d).(\\d{4})"
    options:NSRegularExpressionCaseInsensitive
    error:&error];
 
    [NSStringMask maskString:@"1234567890" withRegex:regex];
    // result: @"1.2345";
 
 @warning If _regex_ doesn't have at least one capturing parentheses `[group]` it's considered invalid and the method returns nil.
 
 @param string A string to be formatted.
 @param regex The regular expression pattern to be applied to the string.
 
 @return A formatted NSString.
 @return nil if string or regex are nil.
 */
+ (NSString *)maskString:(NSString *)string withRegex:(NSRegularExpression *)regex;

/** Formats _string_ based on the given _regex_ filling missing characters with the given _placeholder_.
 
 Similar to maskString:withRegex: except when _string_ is shorted than expected. Then it fills the missing characters with the placeholder:
 
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(\\d).(\\d{3}).(\\d{2})"
    options:NSRegularExpressionCaseInsensitive
    error:&error];
 
    [NSStringMask maskString:@"123" withRegex:regex placeholder:@"_"];
    // result: @"1.23__";
 
 The _placeholder_ length can be bigger than 1, then the method will repeat the _placeholder_ for each group:
 
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(\\d).(\\d{3}).(\\d{2})"
    options:NSRegularExpressionCaseInsensitive
    error:&error];
 
    [NSStringMask maskString:@"123" withRegex:regex placeholder:@"abcdefg"];
    // result: @"1.23a.ab";
 
 @warning If _regex_ doesn't have at least one capturing parentheses `[group]` it's considered invalid and the method returns nil.
 
 @param string A string to be formatted.
 @param regex The regular expression pattern to be applied to the string.
 @param placeholder The placeholder string to fill the voids.
 
 @return A formatted NSString.
 @return nil if string or regex are nil.
 
 @see maskString:withRegex:
 */
+ (NSString *)maskString:(NSString *)string withRegex:(NSRegularExpression *)regex placeholder:(NSString *)placeholder;

/** Formats a _string_ based on the given regular expression _pattern_.
 
 If _string_ is shorter than expected, the method returns a cleaned [NSString](NSString) based on regex groups in _pattern_, but without format:
 
    [NSStringMask maskString:@"123abcd" withPattern:@"(\\d).(\\d{4})"];
    // result: @"123";
 
 This is because the _pattern_ is expecting 5 "formattable" numbers but only 3 are being passed. So it doesn't know how to handle it.
 
 If _string_ is longer than expected, the method returns a formatted NSString until the expected length:
 
    [NSStringMask maskString:@"314159265359" withPattern:@"(\\d).(\\d{4})"];
    // result: @"3.1415";
 
 @warning If _pattern_ doesn't have at least one capturing parentheses `[group]` it's considered invalid and the method returns nil.
 
 @param string A string to be formatted.
 @param pattern The regular expression pattern to be applied to the string.
 
 @return A formatted NSString.
 @return nil if string is nil.
 @return nil if pattern is nil or invalid.
 */
+ (NSString *)maskString:(NSString *)string withPattern:(NSString *)pattern;

/** Formats _string_ based on the given regular expression _pattern_ filling missing characters with the given _placeholder_.
 
 Similar to maskString:withPattern: except when _string_ is shorter than expected. Then it fills the missing characters with the _placeholder_:
 
    [NSStringMask maskString:@"123" withPattern:@"(\\d).(\\d{3}).(\\d{2})" placeholder:@"_"];
    // result: @"1.23__";
 
 The _placeholder_ length can be bigger than 1, then the method will repeat the _placeholder_ for each group:
 
    [NSStringMask maskString:@"123" withPattern:@"(\\d).(\\d{3}).(\\d{2})" placeholder:@"abcdefg"];
    // result: @"1.23a.ab";
 
 @warning If _pattern_ doesn't have at least one capturing parentheses `[group]` it's considered invalid and the method returns nil.
 
 @param string A string to be formatted.
 @param pattern The regular expression pattern to be applied to the string.
 @param placeholder The placeholder string to fill the voids.
 
 @return A formatted NSString.
 @return nil if string is nil.
 @return nil if pattern is nil or invalid.
 
 @see maskString:withPattern:
 */
+ (NSString *)maskString:(NSString *)string withPattern:(NSString *)pattern placeholder:(NSString *)placeholder;

#pragma mark - Instance Methods
/// @name Instance Methods

/** Formats the given _string_ based on the _regex_ set on the instance, filling missing characters with _placeholder_ if not nil.
 
 @param string A string to be formatted based on a pattern.
 
 @return A formatted NSString.
 @return nil if string is nil.
 */
- (NSString *)format:(NSString *)string;

/** Returns only the valid characters in _string_ that matches the instance's _regex_ limited by the expected length.
 
 If _string_ has more valid characters than expected, returns only the expected length.
 
 @param string A string to be validated.
 
 @returns A cleaned string with the expected characters limited to the expected length.
 */
- (NSString *)validCharactersForString:(NSString *)string;

@end
