//
//  Created by escoz on 7/13/11.
//

#import "QBadgeTableCell.h"
#import "QuickDialogTableView.h"


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