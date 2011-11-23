//
//  Created by escoz on 11/1/11.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "QRootElement.h"

@implementation QRootElement (JSONBuilder)

- (void)updateObject:(id)obj withPropertiesFrom:(NSDictionary *)dict {
    for (NSString *key in dict.allKeys){
        id value = [dict valueForKey:key];
        if ([value isKindOfClass:[NSString class]] && [obj respondsToSelector:NSSelectorFromString(key)]) {
            [obj setValue:value forKey:key];
        } else if ([value isKindOfClass:[NSNumber class]]){
            [obj setValue:value forKey:key];
        }
    }
}

- (QElement *)buildElementWithJson:(NSDictionary *)dict {
    QElement *element = [[NSClassFromString([dict valueForKey:@"type"]) alloc] init];
    if (element==nil)
            return nil;
    [self updateObject:element withPropertiesFrom:dict];
    return element;
}

- (void)buildSectionWithJSON:(NSDictionary *)dict {
    QSection *sect = [[QSection alloc] init];
    [self updateObject:sect withPropertiesFrom:dict];
    [self addSection:sect];
    for (id element in (NSArray *)[dict valueForKey:@"elements"]){
       [sect addElement:[self buildElementWithJson:element] ];
    }
}

- (void)buildRootWithJSON:(NSDictionary *)dict {
    [self updateObject:self withPropertiesFrom:dict];
    for (id section in (NSArray *)[dict valueForKey:@"root"]){
        [self buildSectionWithJSON:section];
    }
}

- (id)initWithJSONFile:(NSString *)jsonPath {
    self = [super init];
    if (self!=nil){
        NSError *jsonParsingError = nil;
        NSString *filePath = [[NSBundle mainBundle] pathForResource:jsonPath ofType:@"json"];
        NSDictionary *jsonRoot = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:filePath] options:0 error:&jsonParsingError];
        [self buildRootWithJSON:jsonRoot];
    }
    return self;}


@end