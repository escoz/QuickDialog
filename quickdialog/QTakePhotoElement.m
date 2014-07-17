//
//  QTakePhotoElement.m
//  QuickDialog
//
//  Created by Francis Visoiu Mistrih on 17/07/2014.
//
//

#import "QTakePhotoElement.h"

@implementation QTakePhotoElement

- (QTakePhotoElement *)init
{
    self = [super init];
    if (self) {
        self.photoElements = [NSMutableArray array];
    }
    return self;
}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {
    QTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuickformTakePhotoElement"];
    if (cell == nil){
        cell = [[QTableViewCell alloc] init];
    }

    if (_photoElements.count >= 3) {
        self.enabled = NO;
    }

    [cell applyAppearanceForElement:self];

    cell.textLabel.text = [_title stringByAppendingString:[NSString stringWithFormat:@" (%ld max)",(long)self.maxPhotos]];

    return cell;
}

- (void)selected:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller indexPath:(NSIndexPath *)indexPath {

    if (_photoElements.count < _maxPhotos) {
        QPhotoElement *photoElement = [[QPhotoElement alloc] init];
        [self.parentSection insertElement:photoElement atIndex:self.getIndexPath.row];
        [tableView insertRowsAtIndexPaths:@[self.getIndexPath] withRowAnimation:UITableViewRowAnimationBottom];
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:self.getIndexPath.section] withRowAnimation:UITableViewRowAnimationNone];
    }

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
