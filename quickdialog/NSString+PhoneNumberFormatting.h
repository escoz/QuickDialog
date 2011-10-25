//
//  NSString+PhoneNumberFormatting.m
//
//  Created by Mike Manzano on 7/28/11.
//
//	This work is licensed under a Creative Commons Attribution 3.0 License.
//
//	Adapted from work by Ahmed Abdelkader on 1/22/10, whose work is
//  licensed under a Creative Commons Attribution 3.0 License.
//	http://the-lost-beauty.blogspot.com/2010/01/locale-sensitive-phone-number.html

#import <Foundation/Foundation.h>

// Supported locales
extern NSString *xPhoneNumberLocale_US ;
extern NSString *xPhoneNumberLocale_UK ;
extern NSString *xPhoneNumberLocale_JP;

@interface NSString (PhoneNumberFormatting)
- (NSString *)formattedPhoneNumberForLocale:(NSString *)xPhoneNumberLocale ;
@end