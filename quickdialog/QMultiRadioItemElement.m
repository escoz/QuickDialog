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
#import "QSection.h"
#import "QRootElement.h"
#import "QMultiRadioItemElement.h"

@implementation QMultiRadioItemElement

- (QMultiRadioItemElement *)initWithIndex:(NSUInteger)index RadioElement:(QMultiRadioElement *)radioElement {
    self = [super init];
    _radioElement = radioElement;
    _index = index;
    _title = [[radioElement.items objectAtIndex:_index] description];
    return self;
}

- (QMultiRadioItemElement *)initWithIndex:(NSUInteger)index RadioSection:(QRadioSection *)section {
    self = [super init];
    _radioSection = section;
    _index = index;
    _title = [[_radioSection.items objectAtIndex:_index] description];
    return self;
}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {
    UITableViewCell *cell = [super getCellForTableView:tableView controller:controller];
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
  
  NSNumber* selected = [NSNumber numberWithUnsignedInteger:_index];
  
    cell.accessoryType = [_radioElement.selectedIndexes containsObject:selected] ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    return cell;
}

- (void)selected:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller indexPath:(NSIndexPath *)indexPath {
    [super selected:tableView controller:controller indexPath:indexPath];

  UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];

  NSNumber* selected = [NSNumber numberWithUnsignedInteger:_index];
  selectedCell.accessoryType = ![_radioElement.selectedIndexes containsObject:selected] ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;

  if (![_radioElement.selectedIndexes containsObject:selected]) {
    [_radioElement.selectedIndexes addObject:selected];
  } else {
    [_radioElement.selectedIndexes removeObject:selected];
  }
  
  [_radioElement handleElementSelected:controller];

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end