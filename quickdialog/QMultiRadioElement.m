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
#import "QMultiRadioElement.h"
#import "QMultiRadioItemElement.h"

@implementation QMultiRadioElement {
    QSection *_internalRadioItemsSection;
}

@synthesize values = _values;
@synthesize items = _items;

@synthesize selectedIndexes = _selectedIndexes;
@synthesize selectedItems = _selectedItems;


- (void)createElements {
    _sections = nil;
    _internalRadioItemsSection = [[QSection alloc] init];
    _parentSection = _internalRadioItemsSection;

    [self addSection:_parentSection];

    for (NSUInteger i=0; i< [_items count]; i++){
        [_parentSection addElement:[[QMultiRadioItemElement alloc] initWithIndex:i RadioElement:self]];
    }
}

-(void)setItems:(NSArray *)items {
    _items = items;
    [self createElements];
}

- (NSArray *)selectedItems
{
  NSMutableArray *selectedItems = [NSMutableArray array];
  for (NSNumber *index in _selectedIndexes) {
    [selectedItems addObject:[_items objectAtIndex:[index unsignedIntegerValue]]];
  }
  return selectedItems;
}

- (QMultiRadioElement *)initWithItems:(NSArray *)stringArray selectedIndexes:(NSArray*)selected {
    self = [self initWithItems:stringArray selectedIndexes:selected title:nil];
    return self;
}

- (void)fetchValueIntoObject:(id)obj {
	if (_key==nil)
		return;
	
	[obj setValue:self.selectedIndexes forKey:_key];
}

- (QMultiRadioElement *)initWithItems:(NSArray *)stringArray selectedIndexes:(NSArray*)selected title:(NSString *)title {
    self = [super init];
    if (self!=nil){
      self.items = stringArray;
      
      if (selected!=nil) {
        self.selectedIndexes = [selected mutableCopy];
      } else {
        self.selectedIndexes = [NSMutableArray array]; 
      }
      self.title = title;
    }
    return self;
}

- (void)selected:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller indexPath:(NSIndexPath *)path {
    if (self.sections==nil)
            return;

    [controller displayViewControllerForRoot:self];
}


- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {
    QEntryTableViewCell *cell = (QEntryTableViewCell *) [super getCellForTableView:tableView controller:controller];
  
    NSString *selectedValue = nil;
    if ([_selectedIndexes count] > 0) {
      selectedValue = [self.selectedItems componentsJoinedByString:@", "];
    }

    if (self.title == NULL){
        cell.textField.text = selectedValue;
        cell.detailTextLabel.text = nil;
        cell.imageView.image = nil;
    } else {
        cell.textLabel.text = _title;
        cell.textField.text = selectedValue;
        cell.imageView.image = nil;
    }
    cell.textField.textAlignment = UITextAlignmentRight;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    cell.textField.userInteractionEnabled = NO;
    return cell;
}



@end
