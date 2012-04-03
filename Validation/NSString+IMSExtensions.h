//
//  NSString+IMSExtensions.h
//  PsychAu
//
//  Created by Iain Stubbs on 30/01/12.
//  Copyright (c) 2012 Parallel ThirtyEight South. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (IMSExtensions)

- (NSString*)trimWhitespace;
- (NSString*)concatMutablerrayIntoString:(NSMutableArray *)strings;
- (NSString*)concatMutablerrayIntoDelimitedString:(NSMutableArray *)strings delimiter:(NSString*)theDelimiter;
- (NSArray*)splitString:(NSString*)theString byDelimiter:(NSString*)theDelimiter;
- (NSString*)createUUID;
- (NSString*)createURLwithUsername:(NSString*)username andPassword:(NSString*)password;
- (BOOL)holdsFloatingPointValue;
- (BOOL)holdsFloatingPointValueForLocale:(NSLocale *)locale;
- (BOOL)holdsIntegerValue;
- (BOOL)isBlank;
- (BOOL)contains:(NSString *)string;
- (NSArray *)splitOnChar:(char)ch;
- (NSString *)substringFrom:(NSInteger)from to:(NSInteger)to;
- (NSString *)stringByStrippingWhitespace;
- (BOOL)isLeadingVowel:(NSString*)input;

+ (NSString*)stringWithUUID;

@end
