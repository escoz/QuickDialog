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

#import "QBadgeTableCell.h"
#import "QuickDialogTableView.h"
#import "QBadgeElement.h"

@implementation QBadgeElement
@synthesize badgeColor = _badgeColor;
@synthesize badge = _badge;


- (QBadgeElement *)initWithTitle:(NSString *)title Value:(NSString *)value {
    self = [super init];
    _title = title;
    _badge = value;
    _badgeColor = [UIColor colorWithRed:0.530f green:0.600f blue:0.738f alpha:1.000f];
    return self;

}
- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {
    QBadgeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuickformBadgeElement"];
    if (cell==nil){
        cell = [[QBadgeTableCell alloc] init];
    }
    cell.textLabel.text = _title;
    cell.badgeLabel.text = _badge;
    cell.badgeColor = _badgeColor;
    cell.imageView.image = _image;
    cell.accessoryType = self.sections!= nil || self.controllerAction!=nil ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
    cell.selectionStyle = self.sections!= nil || self.controllerAction!=nil ? UITableViewCellSelectionStyleBlue: UITableViewCellSelectionStyleNone;
    [cell setNeedsDisplay];
    return cell;
}

@end