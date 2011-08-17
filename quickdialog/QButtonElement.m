//
//  Created by escoz on 7/11/11.
//
//  To change this template use File | Settings | File Templates.
//


#import "QElement.h"
#import "QLabelElement.h"
#import "QButtonElement.h"
#import "QuickDialogTableView.h"
#import "QuickDialogController.h"


@implementation QButtonElement



- (QButtonElement *)initWithTitle:(NSString *)title {
    self = [super initWithTitle:title Value:nil];
    return self;
}

- (UITableViewCell *)getCellForTableView:(UITableView *)tableView controller:(QuickDialogController *)controller {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuickformButtonElement"];
    if (cell == nil){
        cell= [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TODO"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    cell.textLabel.text = _title;
    cell.textLabel.textAlignment = UITextAlignmentCenter;
    cell.textLabel.textColor = [UIColor colorWithRed:50.0f/255.0f green:79.0f/255.0f blue:133.0f/255.0f alpha:1];
    return cell;
}

- (void)selected:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller indexPath:(NSIndexPath *)indexPath {
    [super selected:tableView controller:controller indexPath:indexPath];


    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end