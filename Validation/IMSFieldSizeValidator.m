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

    if (theCheck.input.length < minimum || theCheck.input.length > maximum)
    {
        if (messBundle)
        {
             return [NSString stringWithFormat:[messBundle localizedStringForKey:@"FieldSize" value:@"FieldSize" table:nil],minimum,maximum,theCheck.article,theCheck.fieldName];
        }
    }

    return @"";
}


@end