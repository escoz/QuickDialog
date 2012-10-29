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

        if ([propName isEqualToString:@"iterate"] && [object isKindOfClass:[QSection class]]) {
            [self bindSection:(QSection *)object toCollection:[data valueForKeyPath:valueName]];

        } else if ([propName isEqualToString:@"iterate"] && [object isKindOfClass:[QRootElement class]]) {
            [self bindRootElement:(QRootElement *)object toCollection:[data valueForKeyPath:valueName]];

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
    [section.elements removeAllObjects];
    for (id item in [object allKeys]){
        QElement *element = [_builder buildElementWithObject:section.elementTemplate];
        [section addElement:element];
        [element bindToObject:[NSDictionary dictionaryWithObjectsAndKeys:item, @"key", [object valueForKey:item], @"value", nil]];
    }
}

- (NSMutableArray*)fetchCollectionFromSection:(QSection*)section toData:(id)data {
    NSMutableArray * collection = [NSMutableArray new];
    
    for (NSUInteger i = 0; i < section.beforeTemplateElements.count; ++i)
    {
        QElement * el = [section.elements objectAtIndex:i];
        [el fetchValueUsingBindingsIntoObject:data];
    }
    
    for (NSUInteger i = section.beforeTemplateElements.count; i < section.elements.count - section.afterTemplateElements.count; ++i)
    {
        QElement * el = [section.elements objectAtIndex:i];
        for (NSString *each in [el.bind componentsSeparatedByString:@","])
        {
            NSArray *bindingParams = [each componentsSeparatedByString:@":"];
            NSString *propName = [((NSString *) [bindingParams objectAtIndex:0]) stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            NSString *valueName = [((NSString *) [bindingParams objectAtIndex:1]) stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            if ([valueName isEqualToString:@"self"])
            {
                id obj = [el valueForKeyPath:propName];
                [el fetchValueUsingBindingsIntoObject:obj];
                [collection addObject:obj];
            }
        }
    }
    
    for (NSUInteger i = section.elements.count - section.afterTemplateElements.count; i < section.elements.count; ++i)
    {
        QElement * el = [section.elements objectAtIndex:i];
        [el fetchValueUsingBindingsIntoObject:data];
    }
    return collection;
}

- (void)fetchValueFromSection:(QSection *)section toData:(id)data
{
    if (section.bind == nil || ([section.bind length] == 0)) {
        return;
    }
    
    for (NSString *each in [section.bind componentsSeparatedByString:@","])
    {
        NSArray *bindingParams = [each componentsSeparatedByString:@":"];
        NSString *propName = [((NSString *) [bindingParams objectAtIndex:0]) stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSString *valueName = [((NSString *) [bindingParams objectAtIndex:1]) stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        if ([propName isEqualToString:@"iterate"])
        {
            if ([[section.elementTemplate objectForKey:@"bind"] rangeOfString:@"self"].location != NSNotFound)
            {
                NSMutableArray * collection = [self fetchCollectionFromSection:section toData:data];
                [data setValue:collection forKeyPath:valueName];
            }
        } else if (![valueName isEqualToString:@"self"])
        {
            [data setValue:[section valueForKey:propName] forKeyPath:valueName];
        }
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

        if (![propName isEqualToString:@"iterate"] && ![valueName isEqualToString:@"self"])
            [data setValue:[element valueForKey:propName] forKeyPath:valueName];
    }

}
@end