//
//  Created by iainstubbs1959 on 21/03/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "IMSAlphabeticValidator.h"
#import "NSString+IMSExtensions.h"

@implementation IMSAlphabeticValidator

NSBundle *messBundle;

-(IMSAlphabeticValidator*)init
{
    self = [super init];
    messBundle = [NSBundle bundleWithPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"IMSValidationMessages.bundle"]];
    return self;
}

- (NSString*) validate:(IMSValidationCheck*)theCheck
{
    theCheck.input = [theCheck.input trimWhitespace];

    NSError *error             = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[a-zA-Z]" options:0 error:&error];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:theCheck.input options:0 range:NSMakeRange(0, theCheck.input.length)];

    if (numberOfMatches != theCheck.input.length)
    {
        if (messBundle)
        {
            return [NSString stringWithFormat:[messBundle localizedStringForKey:@"Alphabetic" value:@"Alphabetic" table:nil],theCheck.article,theCheck.fieldName];
        }
    }

    return @"";
}

@end