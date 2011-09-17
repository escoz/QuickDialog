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

#import "QuickDialogTableView.h"

@interface QRadioElement : QRootElement {

    NSArray *_items;
    NSArray *_values;
    NSInteger _selected;
}

@property(nonatomic, readonly) NSArray *items;
@property(nonatomic, assign, readwrite) NSInteger selected;
@property(nonatomic, retain) NSArray *values;

- (QRadioElement *)initWithItems:(NSArray *)stringArray selected:(NSInteger)selected;
- (QRadioElement *)initWithItems:(NSArray *)stringArray selected:(NSInteger)selected title:(NSString *)title;
@end