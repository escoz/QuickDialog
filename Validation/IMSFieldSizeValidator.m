//
//  Created by iainstubbs1959 on 21/03/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "IMSFieldSizeValidator.h"
#import "NSString+IMSExtensions.h"

@implementation IMSFieldSizeValidator

@synthesize minimum;
@synthesize maximum;

NSBundle *messBundle;

-(IMSFieldSizeValidator *)init
{
    self = [super init];
    minimum = 0;
    maximum = NSUIntegerMax;
    messBundle = [NSBundle bundleWithPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"IMSValidationMessages.bundle"]];
    return self;
}

-(IMSFieldSizeValidator *)initWithMin:(NSUInteger)min andMax:(NSUInteger)max
{
    self = [super init];
    minimum = min;
    maximum = max;
    messBundle = [NSBundle bundleWithPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"IMSValidationMessages.bundle"]];
    return self;
}

- (NSString*) validate:(IMSValidationCheck*)theCheck
{
    theCheck.input = [theCheck.input trimWhitespace];

    NSRange range = NSMakeRange(minimum, maximum);

    NSError *error = NULL;

    NSString *regexString      = [NSString stringWithFormat:@".{%d,%d}", range.location, range.length];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexString options:0 error:&error];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:theCheck.input options:0 range:NSMakeRange(0, theCheck.input.length)];

    if (numberOfMatches < 1)
    {
        if (messBundle)
        {
             return [NSString stringWithFormat:[messBundle localizedStringForKey:@"FieldSize" value:@"FieldSize" table:nil],minimum,maximum,theCheck.article,theCheck.fieldName];

        }
    }

    return @"";
}


@end