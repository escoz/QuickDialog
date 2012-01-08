//
//  Created by escoz on 1/8/12.
//
#import "BindingEvaluator.h"

@interface BindingEvaluator ()
+ (BOOL)stringIsEmpty:(NSString *)aString;

@end

@implementation BindingEvaluator

+ (void)bindObject:(id)object toData:(id)data {
    if (![object respondsToSelector:@selector(bind)])
        return;

    NSString *string = [object bind];
    if ([self stringIsEmpty:string])
        return;

    for (NSString *each in [string componentsSeparatedByString:@","]) {
        NSArray *bindingParams = [each componentsSeparatedByString:@":"];
        NSString *propName = [((NSString *) [bindingParams objectAtIndex:0]) stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSString *valueName = [((NSString *) [bindingParams objectAtIndex:1]) stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

        if ([data objectForKey:valueName]!=nil)
            [object setValue:[data objectForKey:valueName] forKey:propName];
    }
}


+ (BOOL)stringIsEmpty:(NSString *) aString {
    if (aString == nil || ([aString length] == 0)) {
        return YES;
    }
    aString = [aString stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([aString length] == 0) {
        return YES;
    }
    return NO;
}

@end