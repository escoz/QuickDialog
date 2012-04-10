//
//  Created by iainstubbs1959 on 21/03/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "IMSNumericValidator.h"
#import "NSString+IMSExtensions.h"

@implementation IMSNumericValidator

NSBundle *messBundle;

-(IMSNumericValidator*)init
{
    self = [super init];
    messBundle = [NSBundle bundleWithPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"IMSValidationMessages.bundle"]];
    return self;
}

- (NSString*) validate:(IMSValidationCheck*)theCheck
{
    theCheck.input = [theCheck.input trimWhitespace];
    
    NSError *error             = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:0 error:&error];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:theCheck.input options:0 range:NSMakeRange(0, theCheck.input.length)];
    
    if (numberOfMatches != theCheck.input.length)
    {
        if (messBundle)
        {
            return [NSString stringWithFormat:[NSString stringWithFormat:[messBundle localizedStringForKey:@"Numeric" value:@"Numeric" table:nil],theCheck.article,theCheck.fieldName]];
        }
    }
    
    return @"";
}

@end