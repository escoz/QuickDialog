//
//  Created by iainstubbs1959 on 21/03/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "IMSFieldSizeValidator.h"


@implementation IMSFieldSizeValidator

@synthesize minimum;
@synthesize maximum;

SharedDataSingleton *mSds;

-(IMSFieldSizeValidator *)init
{
    self = [super init];
    minimum = 0;
    maximum = NSUIntegerMax;
    mSds = [SharedDataSingleton sharedSingleton];
    return self;
}

-(IMSFieldSizeValidator *)initWithMin:(NSUInteger)min andMax:(NSUInteger)max
{
    self = [super init];
    minimum = min;
    maximum = max;
    mSds = [SharedDataSingleton sharedSingleton];
    return self;
}

- (NSString*) validate:(IMSValidationCheck*)theCheck
{
    theCheck.input = [theCheck.input trimWhitespace];

    if (theCheck.input.length < minimum || theCheck.input.length > maximum)
    {
        if (mSds.validationBundle)
        {
             return [NSString stringWithFormat:[mSds.validationBundle localizedStringForKey:@"FieldSize" value:@"FieldSize" table:nil],minimum,maximum,theCheck.article,theCheck.fieldName];

        }
    }

    return @"";
}


@end