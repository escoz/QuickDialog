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
#import "QBadgeLabel.h"

@implementation QBadgeElement {

}

- (instancetype)init {
    self = [super init];
    if (self!=nil)
    {
        self.badgeColor = nil;
        self.badgeTextColor = [UIColor whiteColor];
        self.cellClass = [QBadgeTableCell class];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title Value:(NSString *)value {
    self = [self init];
	if (self) {
		self.title = title;
		self.badge = value;
	}
    return self;
}

- (void)setCurrentCell:(UITableViewCell *)currentCell
{
    super.currentCell = currentCell;

    QBadgeTableCell *cell = (QBadgeTableCell *) currentCell;
    cell.textLabel.text = self.title;
    [cell applyAppearanceForElement:self];
    cell.badgeLabel.textColor = self.badgeTextColor;

    if ([cell respondsToSelector:@selector(tintColor)])
        cell.badgeLabel.badgeColor = self.badgeColor == nil ? cell.tintColor : self.badgeTextColor;
    else
        cell.badgeLabel.badgeColor = self.badgeColor;

    cell.badgeLabel.text = self.badge;
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.imageView.image = self.image;
    cell.accessoryType = self.sections!= nil || self.controllerAction!=nil ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
    cell.selectionStyle = self.sections!= nil || self.controllerAction!=nil ? UITableViewCellSelectionStyleBlue: UITableViewCellSelectionStyleNone;

}


@end
