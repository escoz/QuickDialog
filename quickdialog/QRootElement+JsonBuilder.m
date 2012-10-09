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


#import <objc/runtime.h>
#import "QRootBuilder.h"

@implementation QRootElement (JsonBuilder)


- (QRootElement *)initWithJSONFile:(NSString *)jsonPath {
    self = [self initWithJSONFile:jsonPath andData:nil];
    return self;
}

+ (Class)JSONParserClass {
    return objc_getClass("NSJSONSerialization");
}

- (QRootElement *)initWithJSONFile:(NSString *)jsonPath andData:(id)data {
    Class JSONSerialization = [QRootElement JSONParserClass];
    NSAssert(JSONSerialization != NULL, @"No JSON serializer available!");

    NSError *jsonParsingError = nil;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:jsonPath ofType:@"json"];
    NSDictionary *jsonRoot = [JSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:filePath] options:0 error:&jsonParsingError];

    self = [self initWithJSON:jsonRoot andData:data];
    return self;
}

- (QRootElement *)initWithJSON:(id)jsonRoot andData:(id)data {

    self = [[QRootBuilder new] buildWithObject:jsonRoot];
    if (data!=nil)
        [self bindToObject:data];
    return self;
}

- (QRootElement *)initWithJSONFile:(NSString *)jsonPath andDataJSONFile:(NSString *)dataPath {
    Class JSONSerialization = [QRootElement JSONParserClass];
    NSAssert(JSONSerialization != NULL, @"No JSON serializer available!");

    NSError *jsonParsingError = nil;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:dataPath ofType:@"json"];
    NSDictionary *data = [JSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:filePath] options:0 error:&jsonParsingError];

    return [self initWithJSONFile:jsonPath andData:data];
}

+ (QRootElement *)rootForJSON:(NSString *)json {
    QRootElement *root = [[self alloc] initWithJSONFile:json];
    return root;
}



@end