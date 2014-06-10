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

#import "QEmptyListElement.h"
#import "QElement+Appearance.h"
#import "QAppearance.h"

@implementation QEmptyListElement

- (instancetype)init {
    self = [super initWithTitle:@"Empty" Value:nil];
    return self;
}

- (void)setCurrentCell:(UITableViewCell *)cell
{
    super.currentCell = cell;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = _title;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.textColor = [UIColor colorWithWhite:0.7f alpha:1.0f];
    cell.textLabel.font = self.appearance.titleFont;
}

- (void)selected:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller indexPath:(NSIndexPath *)indexPath {
}


@end
