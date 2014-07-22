//
//  QTakePhotoElement.m
//  QuickDialog
//
//  Created by Francis Visoiu Mistrih on 16/07/2014.
//
//

#import "QTakePhotoElement.h"

#define green_color [UIColor colorWithRed:0.373 green:0.878 blue:0.471 alpha:1]
const NSString *kInitTakeTitle = @"Prendre photo";
const NSString *kPhotoSource = @"Source photo";
const NSString *kCancelActionSheet = @"Annuler";
const NSString *kChooseFromLibrary = @"Choisir une photo";
const NSString *kChooseFromCamera = @"Prendre une photo";

@implementation QTakePhotoElement

- (QTakePhotoElement *)init
{
    self = [super init];
    if (self) {
        _photoData = [[MEPhotoDataItem alloc] init];
        _photoData.takeTitle = [NSString stringWithFormat:@"%@",kInitTakeTitle];
        self.appearance = [self.appearance copy];
    }
    return self;
}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {
    QTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuickformPhotoElement"];
    if (cell == nil){
        cell = [[QTableViewCell alloc] initWithReuseIdentifier:@"QuickformPhotoElement"];
    }
    [cell applyAppearanceForElement:self];

    cell.textLabel.text = _photoData.isPhotoTaken ? _photoData.previewTitle : _photoData.takeTitle;
    return cell;
}

- (void)selected:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller indexPath:(NSIndexPath *)indexPath {
    if (_photoData.isPhotoTaken) {
        //show the photo to the user
        QPhotoViewController *vc = [[QPhotoViewController alloc] initWithPhotoData:_photoData type:PhotoSourceCamera];
        vc.element = self;
        [controller.navigationController pushViewController:vc animated:YES];
    } else {
        //if the user has no camera, get the photo from saved album
        //if the user has one, give him the choice
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [self presentCameraWithSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
        } else {
            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:[NSString stringWithFormat:@"%@",kPhotoSource] delegate:self cancelButtonTitle:[NSString stringWithFormat:@"%@",kCancelActionSheet] destructiveButtonTitle:nil otherButtonTitles:[NSString stringWithFormat:@"%@",kChooseFromLibrary], [NSString stringWithFormat:@"%@",kChooseFromCamera] ,nil];
            [actionSheet showInView:self.controller.view];
        }
    }

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)presentCameraWithSourceType:(UIImagePickerControllerSourceType)sourceType {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = NO;
    picker.sourceType = sourceType;

    [self.controller presentViewController:picker animated:YES completion:nil];
}

#pragma mark UIImagePickerController delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    _photoData.metadata = [info objectForKey:UIImagePickerControllerMediaMetadata];
    if (!_photoData.metadata) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Erreur" message:@"La photo selectionnée n'est pas conforme aux règles Mobeye." delegate:self cancelButtonTitle:[NSString stringWithFormat:@"%@",kCancelActionSheet] otherButtonTitles:nil];
        [alert show];
    } else {
        _photoData.image = [info objectForKey:UIImagePickerControllerOriginalImage];
        _photoData.isPhotoTaken = YES;
        [self.appearance setBackgroundColorEnabled:green_color];

        
    }

    [picker dismissViewControllerAnimated:YES completion:^{
        [[(QuickDialogController *)self.controller quickDialogTableView] reloadCellForElements:self, nil];
    }];
}

#pragma mark UIActionSheet delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            [self presentCameraWithSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
            break;
        case 1:
            [self presentCameraWithSourceType:UIImagePickerControllerSourceTypeCamera];
            break;
        default:
            NSLog(@"Wrong action sheet button index.");
            break;
    }
}

@end
