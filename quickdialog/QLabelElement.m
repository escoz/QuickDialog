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

@implementation QLabelElement {
@private
    UITableViewCellAccessoryType _accessoryType;
    UIFont* _font;
}


@synthesize image = _image;
@synthesize value = _value;
@synthesize accessoryType = _accessoryType;
@synthesize font = _font;

- (QLabelElement *)init {
    self = [super init];
    if (self) {
        _font = [UIFont systemFontOfSize:17];
    }
    return self;
}
- (QLabelElement *)initWithTitle:(NSString *)title Value:(id)value {
    self = [super init];
    if (self) {
        _title = title;
        _value = value;
        _font = [UIFont systemFontOfSize:17];
    }
    return self;
}

-(void)setImageNamed:(NSString *)name {
    self.image = [UIImage imageNamed:name];
}

- (NSString *)imageNamed {
    return nil;
}


- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {
    QTableViewCell *cell = (QTableViewCell *) [super getCellForTableView:tableView controller:controller];
    cell.accessoryType = _accessoryType== (int) nil ? UITableViewCellAccessoryNone : _accessoryType;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    cell.textLabel.text = _title;
    cell.detailTextLabel.text = [_value description];
    if (self.valueLineBreakPolicy == QValueLineBreakPolicyWrap) {
        cell.detailTextLabel.numberOfLines = 0;
    }
    cell.detailTextLabel.font = self.font;
    cell.imageView.image = _image;
    cell.accessoryType = self.sections!= nil || self.controllerAction!=nil ? (_accessoryType != (int) nil ? _accessoryType : UITableViewCellAccessoryDisclosureIndicator) : UITableViewCellAccessoryNone;
    cell.selectionStyle = self.sections!= nil || self.controllerAction!=nil ? UITableViewCellSelectionStyleBlue: UITableViewCellSelectionStyleNone;

    return cell;
}

- (void)selected:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller indexPath:(NSIndexPath *)path {
    [super selected:tableView controller:controller indexPath:path];
}


- (CGFloat)getRowHeightForTableView:(QuickDialogTableView *)tableView {
    if (self.valueLineBreakPolicy == QValueLineBreakPolicyWrap) {
        CGSize constraint = CGSizeMake(tableView.frame.size.width-(tableView.root.grouped ? 40.f : 20.f), 20000);
        CGSize  size= [[_value description] sizeWithFont:_font constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
        CGFloat predictedHeight = size.height + 20.0f;
        if (self.title!=nil)
            predictedHeight+=30;
        return (_height >= predictedHeight) ? _height : predictedHeight;
        
    } else {
        return [super getRowHeightForTableView:tableView];
    }
}
@end