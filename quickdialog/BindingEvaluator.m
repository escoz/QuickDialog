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

        if ([propName isEqualToString:@"iterate"] && [object isKindOfClass:[QSection class]]) {
            [BindingEvaluator bindSection:(QSection *)object toCollection:[data objectForKey:valueName]];
            
        } else if ([propName isEqualToString:@"iterateproperties"] && [object isKindOfClass:[QSection class]]) {
            NSLog(@"iterate prop %@ %@", data, [data objectForKey:valueName]);
            [BindingEvaluator bindSection:(QSection *)object toProperties:[data objectForKey:valueName]];

        } else if ([data objectForKey:valueName]!=nil) {
            [object setValue:[[data objectForKey:valueName] description] forKey:propName];

        }
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

+ (void)bindSection:(QSection *)section toCollection:(NSArray *)items {
    [section.elements removeAllObjects];
    for (id item in items){
        QElement *element = [section.rootElement buildElementWithJson:section.template];
        [section addElement:element];
        [element bindToObject:item];
    }
}

+ (void)bindSection:(QSection *)section toProperties:(NSDictionary *)object {
    [section.elements removeAllObjects];
    for (id item in [object allKeys]){
        NSLog(@"bindig %@", item);
        QElement *element = [section.rootElement buildElementWithJson:section.template];
        [section addElement:element];
        [element bindToObject:[NSDictionary dictionaryWithObjectsAndKeys:item, @"key", [object valueForKey:item], @"value", nil]];
    }
  
}
@end