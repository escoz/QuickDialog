#import "QPickerElement.h"


@implementation QPickerElement

- (void)createElements {
    // nil
}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {
    UITableViewCell *const cell = [super getCellForTableView:tableView controller:controller];
    cell.accessoryType = UITableViewCellAccessoryNone;
    return cell;
}

- (void)selected:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller indexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



@end