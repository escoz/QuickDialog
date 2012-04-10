//
//  Created by iainstubbs1959 on 21/03/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "IMSAlphanumericValidator.h"
#import "NSMutableArray+IMSExtensions.h"
#import "Validation.h"
#import "NSString+IMSExtensions.h"

@implementation IMSAlphanumericValidator

NSBundle *messBundle;

-(IMSAlphanumericValidator*)init
{
    self = [super init];
    messBundle = [NSBundle bundleWithPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"IMSValidationMessages.bundle"]];
    return self;
}

- (NSString*) validate:(IMSValidationCheck*)theCheck
{
    theCheck.input = [theCheck.input trimWhitespace];

    NSError *error             = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[0-9a-zA-Z]" options:0 error:&error];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:theCheck.input options:0 range:NSMakeRange(0, theCheck.input.length)];

    if (numberOfMatches != theCheck.input.length)
    {
        if (messBundle)
        {
            return [NSString stringWithFormat:[messBundle localizedStringForKey:@"Alphanumeric" value:@"Alphanumeric" table:nil],theCheck.article,theCheck.fieldName];
        }
    }

    return @"";
}

@end