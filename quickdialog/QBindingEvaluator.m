//
// Copyright 2011 ESCOZ Inc  - http://escoz.com
//
// Licensed under the Apache License, Version 2.0 (the "License"); you may not use this
// file except in compliance with the License. You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software distributed under
// the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF
// ANY KIND, either express or implied. See the License for the specific language governing
// permissions and limitations under the License.
//

#import "QBindingEvaluator.h"

@interface QBindingEvaluator ()
+ (BOOL)stringIsEmpty:(NSString *)aString;

@end

@implementation QBindingEvaluator {
    QRootBuilder *_builder;
}
- (id)init {
    self = [super init];
    if (self) {
       _builder = [QRootBuilder new];
    }

    return self;
}

- (void)bindObject:(id)object toData:(id)data {
    if (![object respondsToSelector:@selector(bind)])
        return;

    NSString *string = [object bind];
    if ([QBindingEvaluator stringIsEmpty:string])
        return;

    for (NSString *each in [string componentsSeparatedByString:@","]) {
        NSArray *bindingParams = [each componentsSeparatedByString:@":"];

        NSString *propName = [((NSString *) [bindingParams objectAtIndex:0]) stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSString *valueName = [((NSString *) [bindingParams objectAtIndex:1]) stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        
        // Format for converters is value/className/argument or value/className
        // Embedded slashes are not allowed in the argument.
        NSArray *converterParams = [valueName componentsSeparatedByString:@"/"];
        valueName = [converterParams objectAtIndex: 0];
        
        id value;
        if ([valueName isEqualToString:@"self"]) {
            value = data;
        } else {
            value = [data valueForKeyPath: valueName];
        }
        
        if (converterParams.count > 1) {
            QConverter *converter = [[NSClassFromString([converterParams objectAtIndex: 1]) alloc] init];
            if (converterParams.count > 2) {
                value = [converter convert: value argument: [converterParams objectAtIndex: 2]];
            } else {
                value = [converter convert: value argument: nil];
            }
        }                                 

        if ([propName isEqualToString:@"iterate"] && [object isKindOfClass:[QSection class]]) {
            [self bindSection:(QSection *)object toCollection:value];
            
        } else if ([propName isEqualToString:@"iterateproperties"] && [object isKindOfClass:[QSection class]]) {
            [self bindSection:(QSection *)object toProperties:value];

        }  else {
            [QRootBuilder trySetProperty:propName onObject:object withValue:value];
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

- (void)bindSection:(QSection *)section toCollection:(NSArray *)items {
    [section.elements removeAllObjects];

    for (id item in items){
        QElement *element = [_builder buildElementWithObject:section.elementTemplate];
        [section addElement:element];
        [element bindToObject:item];
    }
}

- (void)bindSection:(QSection *)section toProperties:(NSDictionary *)object {
    [section.elements removeAllObjects];
    for (id item in [object allKeys]){
        QElement *element = [_builder buildElementWithObject:section.elementTemplate];
        [section addElement:element];

        [element bindToObject:[NSDictionary dictionaryWithObjectsAndKeys:item, @"key", [object valueForKey:item], @"value", nil]];
    }
}

@end