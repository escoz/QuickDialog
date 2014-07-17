//
//  QPhotoElement.m
//  QuickDialog
//
//  Created by Francis Visoiu Mistrih on 16/07/2014.
//
//

#import "QPhotoElement.h"

@implementation QPhotoElement

- (QPhotoElement *)init
{
    self = [super init];
    if (self) {
        _isPhotoTaken = false;
    }
    return self;
}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {
    QTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuickformPhotoElement"];
    if (cell == nil){
        cell = [[QTableViewCell alloc] init];
    }
    [cell applyAppearanceForElement:self];

    cell.textLabel.text = _isPhotoTaken ? @"Photo prise" : @"Prendre photo";
    return cell;
}

- (void)selected:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller indexPath:(NSIndexPath *)indexPath {
    if (_isPhotoTaken) {
#warning maybe show the photo
    } else {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
#warning to change to self.controller
        picker.delegate = self;
        //picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.allowsEditing = NO;
        [controller presentViewController:picker animated:YES completion:nil];
    }

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    _image = [info objectForKey:UIImagePickerControllerOriginalImage];
    _isPhotoTaken = YES;
    [picker dismissViewControllerAnimated:YES completion:^{
        [[(QuickDialogController *)self.controller quickDialogTableView] reloadCellForElements:self, nil];
    }];
}

@end
