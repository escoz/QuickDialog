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


#import <Foundation/Foundation.h>

@class QSection;
@class QRootElement;
@class QElement;


@interface QBindingEvaluator : NSObject {
}

- (void)bindObject:(id)section toData:(id)data;

- (void)bindObject:(id)object toData:(id)data withString:(id)string;

- (void)bindSection:(QSection *)section toCollection:(NSArray *)items;

- (void)bindSection:(QSection *)section toProperties:(id)object;

- (void)bindRootElement:(QRootElement *)element toCollection:(NSArray *)items;

- (void)fetchValueFromObject:(QElement *)element toData:(id)data;

@end
