//
//  Created by escoz on 7/7/11.
//
//  To change this template use File | Settings | File Templates.
//


#import "Element.h"
#import "LabelElement.h"
#import "QuickDialogController.h"
#import "RootElement.h"

@implementation LabelElement

@synthesize image = _image;
@synthesize value = _value;


- (LabelElement *)initWithTitle:(NSString *)title Value:(NSString *)value {
   self = [super init];
   _title = title;
   _value = value;
    return self;
}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {
    UITableViewCell *cell = [super getCellForTableView:tableView controller:controller];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    cell.textLabel.text = _title;
    cell.detailTextLabel.text = _value;
    cell.imageView.image = _image;
    cell.accessoryView = nil;
    cell.accessoryType = self.sections!= nil || self.controllerAction!=nil ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
    cell.selectionStyle = self.sections!= nil || self.controllerAction!=nil ? UITableViewCellSelectionStyleBlue: UITableViewCellSelectionStyleNone;

    return cell;
}

- (void)selected:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller indexPath:(NSIndexPath *)path {
    [super selected:tableView controller:controller indexPath:path];
}


@end