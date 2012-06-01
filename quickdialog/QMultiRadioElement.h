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

@interface QMultiRadioElement : QEntryElement {
    NSArray *_items;
    NSArray *_values;

  NSMutableArray* _selectedIndexes;
  NSMutableArray* _selectedItems;
}

@property(nonatomic, retain) NSArray *items;
@property(nonatomic, retain) NSArray *values;

@property (nonatomic, strong)   NSMutableArray  *selectedIndexes;
@property (nonatomic, readonly) NSArray         *selectedItems;

- (void)createElements;

- (QMultiRadioElement *)initWithItems:(NSArray *)stringArray selectedIndexes:(NSArray*)selected;
- (QMultiRadioElement *)initWithItems:(NSArray *)stringArray selectedIndexes:(NSArray*)selected title:(NSString *)title;
@end