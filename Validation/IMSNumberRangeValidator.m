//
//  Created by iainstubbs1959 on 21/03/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "IMSNumberRangeValidator.h"
#import "NSString+IMSExtensions.h"
#import "Validation.h"

@implementation IMSNumberRangeValidator

@synthesize minimum;
@synthesize maximum;

NSBundle *messBundle;

-(IMSNumberRangeValidator *)init
{
    self = [super init];
    minimum = 0;
    maximum = NSIntegerMax;
    messBundle = [NSBundle bundleWithPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"IMSValidationMessages.bundle"]];
    return self;
}

-(IMSNumberRangeValidator *)initWithMin:(NSInteger)min andMax:(NSInteger)max
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

    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber * myNumber = [f numberFromString:theCheck.input];
    NSInteger ab = [myNumber integerValue];

    if (ab > maximum || ab < minimum)
    {
        if (messBundle)
        {
            return [NSString stringWithFormat:[messBundle localizedStringForKey:@"NumberRange" value:@"NumberRange" table:nil],minimum,maximum,theCheck.article,theCheck.fieldName];
        }
    }

    return @"";
}


@end