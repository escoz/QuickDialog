//
//  QTakePhotoElement.m
//  QuickDialog
//
//  Created by Francis Visoiu Mistrih on 16/07/2014.
//
//

#import "QTakePhotoElement.h"

const NSString *kInitPreviewTitle = @"Voir photo";
const NSString *kInitTakeTitle = @"Prendre photo";

@implementation QTakePhotoElement

- (QTakePhotoElement *)init
{
    self = [super init];
    if (self) {
        _isPhotoTaken = false;
        _previewTitle = [NSString stringWithFormat:@"%@",kInitPreviewTitle];
        _takeTitle = [NSString stringWithFormat:@"%@",kInitTakeTitle];
    }
    return self;
}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {
    QTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuickformPhotoElement"];
    if (cell == nil){
        cell = [[QTableViewCell alloc] initWithReuseIdentifier:@"QuickformPhotoElement"];
    }
    [cell applyAppearanceForElement:self];

    cell.textLabel.text = _isPhotoTaken ? _previewTitle : _takeTitle;
    return cell;
}

- (void)selected:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller indexPath:(NSIndexPath *)indexPath {
    if (_isPhotoTaken) {
        //show the photo to the user
        QPhotoViewController *vc = [[QPhotoViewController alloc] initWithPhoto:_image andType:PhotoSourceCamera];
        [controller.navigationController pushViewController:vc animated:YES];
    } else {
        //take a new picture
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.allowsEditing = NO;
        [controller presentViewController:picker animated:YES completion:nil];
    }

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    _image = [info objectForKey:UIImagePickerControllerOriginalImage];
    _metadata = [info objectForKey:UIImagePickerControllerMediaMetadata];

    _isPhotoTaken = YES;
    [picker dismissViewControllerAnimated:YES completion:^{
        [[(QuickDialogController *)self.controller quickDialogTableView] reloadCellForElements:self, nil];
    }];
}

@end
