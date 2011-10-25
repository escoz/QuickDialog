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


#import "NSString+PhoneNumberFormatting.h"

NSString *xPhoneNumberLocale_US = @"us" ;
NSString *xPhoneNumberLocale_UK = @"uk" ;
NSString *xPhoneNumberLocale_JP = @"jp" ;


@implementation NSString (PhoneNumberFormatting)

+ (NSDictionary *) sharedPhoneFormats
{
	static NSDictionary *formats = nil ;
	
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		NSArray *usPhoneFormats = [NSArray arrayWithObjects:
								   @"+1 (###) ###-####",
								   @"1 (###) ###-####",
								   @"011 $",
								   @"###-####",
								   @"(###) ###-####", nil];
		
		NSArray *ukPhoneFormats = [NSArray arrayWithObjects:
								   @"+44 ##########",
								   @"00 $",
								   @"0### - ### ####",
								   @"0## - #### ####",
								   @"0#### - ######", nil];
		
		NSArray *jpPhoneFormats = [NSArray arrayWithObjects:
								   @"+81 ############",
								   @"001 $",
								   @"(0#) #######",
								   @"(0#) #### ####", nil];
		
		formats = [[NSDictionary alloc] initWithObjectsAndKeys:
                   usPhoneFormats, xPhoneNumberLocale_US,
                   ukPhoneFormats, xPhoneNumberLocale_UK,
                   jpPhoneFormats, xPhoneNumberLocale_JP,
                   nil];
    });
	
	return formats ;
}


- (BOOL)canBeInputByPhonePad:(char)c 
{
	if(c == '+' || c == '*' || c == '#') return YES;
	if(c >= '0' && c <= '9') return YES;
	return NO;
}

// Strips out invalid characters
- (NSString *)strip:(NSString *)phoneNumber 
{
	NSMutableString *res = [[NSMutableString alloc] init];
	for(int i = 0; i < [phoneNumber length]; i++) 
    {
		char next = [phoneNumber characterAtIndex:i];
		if([self canBeInputByPhonePad:next])
			[res appendFormat:@"%c", next];
    }
	return res;
}


- (NSString *)formattedPhoneNumberForLocale:(NSString *)xPhoneNumberLocale 
{
	NSString *phoneNumber = self ;
	NSArray *localeFormats = [[NSString sharedPhoneFormats] objectForKey:xPhoneNumberLocale];
	if(localeFormats == nil) return phoneNumber;
	NSString *input = [self strip:phoneNumber];
	for(NSString *phoneFormat in localeFormats) 
    {
		int i = 0;
		NSMutableString *temp = [[NSMutableString alloc] init];
		for(int p = 0; temp != nil && i < [input length] && p < [phoneFormat length]; p++) 
        {
			char c = [phoneFormat characterAtIndex:p];
			BOOL required = [self canBeInputByPhonePad:c];
			char next = [input characterAtIndex:i];
			switch(c) 
            {
				case '$':
					p--;
					[temp appendFormat:@"%c", next]; i++;
					break;
				case '#':
					if(next < '0' || next > '9') 
                    {
						temp = nil;
						break;
                    }
					[temp appendFormat:@"%c", next]; i++;
					break;
				default:
					if(required) 
                    {
						if(next != c) 
                        {
							temp = nil;
							break;
                        }
						[temp appendFormat:@"%c", next]; i++;
                    } 
					else 
                    {
						[temp appendFormat:@"%c", c];
						if(next == c) i++;
                    }
                    break;
            }
        } // build temp loop
		if(i == [input length]) 
        {
			return temp;
        }
    } // for each format
	return input;
}
@end
