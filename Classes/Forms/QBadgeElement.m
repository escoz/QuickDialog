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
#import "QBadgeElement.h"
#import "QuickDialog.h"

@implementation QBadgeElement {

}
@synthesize badgeTextColor = _badgeTextColor;
@synthesize badgeColor = _badgeColor;
@synthesize badge = _badge;

- (QBadgeElement *)init {
    self = [super init];
    _badgeColor = nil;
    _badgeTextColor = [UIColor whiteColor];
    return self;
}

- (QBadgeElement *)initWithTitle:(NSString *)title Value:(NSString *)value {
    self = [self init];
	if (self) {
		_title = title;
		_badge = value;
	}
    return self;
}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {
    QBadgeTableCell *cell = [[QBadgeTableCell alloc] init];
    cell.textLabel.text = _title;
    [cell applyAppearanceForElement:self];
    cell.badgeLabel.textColor = _badgeTextColor;

    if ([cell respondsToSelector:@selector(tintColor)])
        cell.badgeLabel.badgeColor = _badgeColor == nil ? cell.tintColor : _badgeTextColor;
    else
       cell.badgeLabel.badgeColor = _badgeColor;

    cell.badgeLabel.text = _badge;
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.imageView.image = _image;
    cell.accessoryType = self.sections!= nil || self.controllerAction!=nil ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
    cell.selectionStyle = self.sections!= nil || self.controllerAction!=nil ? UITableViewCellSelectionStyleBlue: UITableViewCellSelectionStyleNone;
    return cell;
}

@end
