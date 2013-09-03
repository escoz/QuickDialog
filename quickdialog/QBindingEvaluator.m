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
#import "QuickDialog.h"

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

        if ([propName isEqualToString:@"iterate"] && [object isKindOfClass:[QSection class]]) {
            [self bindSection:(QSection *)object toCollection:[data valueForKeyPath:valueName]];

        } else if ([propName isEqualToString:@"iterate"] && [object isKindOfClass:[QRootElement class]]) {
            NSArray *itemsToIterate = [valueName isEqualToString:@"self"]? data : [data valueForKeyPath:valueName];
            [self bindRootElement:(QRootElement *) object toCollection:itemsToIterate];

        } else if ([propName isEqualToString:@"iterateproperties"] && [object isKindOfClass:[QSection class]]) {
            [self bindSection:(QSection *)object toProperties:[data valueForKeyPath:valueName]];

        } else if ([valueName isEqualToString:@"self"]) {
            [QRootBuilder trySetProperty:propName onObject:object withValue:data localized:NO];

        } else {
            [QRootBuilder trySetProperty:propName onObject:object withValue:[data valueForKeyPath:valueName] localized:NO];
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

    for (id item in section.beforeTemplateElements){
        QElement *element = [_builder buildElementWithObject:item];
        [section addElement:element];
        [element bindToObject:item];
    }

    for (id item in items){
        QElement *element = [_builder buildElementWithObject:section.elementTemplate];
        [section addElement:element];
        [element bindToObject:item];
    }

    for (id item in section.afterTemplateElements){
        QElement *element = [_builder buildElementWithObject:item];
        [section addElement:element];
        [element bindToObject:item];
    }
}

- (void)bindRootElement:(QRootElement *)element toCollection:(NSArray *)items  {
    [element.sections removeAllObjects];
    for (id item in items){
        QSection *section = [_builder buildSectionWithObject:element.sectionTemplate];
        [element addSection:section];
        [section bindToObject:item];
    }
    if (element.sections.count==0 && element.emptyMessage !=nil){
        QSection *section = [[QSection alloc] init];
        [section addElement:[[QTextElement alloc] initWithText:element.emptyMessage]];
        [element addSection:section];
    }
}

- (void)bindSection:(QSection *)section toProperties:(NSDictionary *)object {
    if ([object isKindOfClass:[NSNull class]]) {
        return;
    }
    [section.elements removeAllObjects];
    for (id item in [object allKeys]){
        QElement *element = [_builder buildElementWithObject:section.elementTemplate];
        [section addElement:element];
        [element bindToObject:[NSDictionary dictionaryWithObjectsAndKeys:item, @"key", [object valueForKey:item], @"value", nil]];
    }
}

- (void)fetchValueFromObject:(QElement *)element toData:(id)data {
     if (element.bind == nil || ([element.bind length] == 0)) {
        return;
    }

    for (NSString *each in [element.bind componentsSeparatedByString:@","])
    {
        NSArray *bindingParams = [each componentsSeparatedByString:@":"];
        NSString *propName = [((NSString *) [bindingParams objectAtIndex:0]) stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSString *valueName = [((NSString *) [bindingParams objectAtIndex:1]) stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

        if (![propName isEqualToString:@"iterate"] && ![valueName isEqualToString:@"self"]) {
            @try {
                id value = [element valueForKeyPath:propName];
                if (propName!= nil && value!=nil)
                    [data setValue:value forKeyPath:valueName];
                }
            @catch (NSException *exception) {
                NSLog(@"Couldn't set property %@ on object %@", valueName, data);
            }
        }
    }

}
@end
