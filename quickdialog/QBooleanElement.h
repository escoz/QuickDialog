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

#import "QLabelElement.h"

@interface QBooleanElement : QLabelElement {
    BOOL _boolValue;
    BOOL _enabled;
    UIImage *_onImage;
    UIImage *_offImage;
}

@property(nonatomic, retain) UIImage *onImage;
@property(nonatomic, retain) UIImage *offImage;
@property(nonatomic, readwrite) NSNumber *numberValue;
@property (nonatomic) BOOL boolValue;
@property(nonatomic) BOOL enabled;

- (QBooleanElement *)initWithTitle:(NSString *)title BoolValue:(BOOL)value;


- (void)setOnImageName:(NSString *)name;

- (void)setOffImageName:(NSString *)name;


- (void)switched:(id)switched;
@end
