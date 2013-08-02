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
#import "QEntryElement.h"

/**
  QRadioElement: allows user to select one of multiple options available. Automatically pushes a new table with the item to be selected.
*/

@interface QRadioElement : QEntryElement {
    NSArray *_items;
    NSArray *_values;
    NSInteger _selected;
}

@property(nonatomic, retain) NSArray *items;
@property(nonatomic, assign) id selectedItem;
@property(nonatomic, assign, readwrite) NSInteger selected;
@property(nonatomic, retain) NSArray *values;
@property(nonatomic, strong) NSArray *itemsImageNames;

- (QRadioElement *)initWithDict:(NSDictionary *)valuesDictionary selected:(int)selected title:(NSString *)title;

- (void)createElements;

- (NSObject *)selectedValue;
- (void)setSelectedValue:(NSObject *)aSelected;

- (QRadioElement *)initWithItems:(NSArray *)stringArray selected:(NSInteger)selected;
- (QRadioElement *)initWithItems:(NSArray *)stringArray selected:(NSInteger)selected title:(NSString *)title;

- (void)updateCell:(QEntryTableViewCell *)cell selectedValue:(id)selectedValue;

@end
