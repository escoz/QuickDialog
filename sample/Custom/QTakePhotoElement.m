//
//  QTakePhotoElement.m
//  QuickDialog
//
//  Created by Francis Visoiu Mistrih on 16/07/2014.
//
//

#import "QTakePhotoElement.h"

const NSString *kInitTakeTitle = @"Prendre photo";
const NSString *kChooseFromLibrary = @"Choisir une photo";
const NSString *kChooseFromCamera = @"Prendre une photo";

@implementation QTakePhotoElement

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {
    QTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuickformPhotoElement"];
    if (cell == nil){
        cell = [[QTableViewCell alloc] initWithReuseIdentifier:@"QuickformPhotoElement"];
    }
    [cell applyAppearanceForElement:self];

    cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.photoData[@"isPhotoTaken"] boolValue] ? kPreviewPhoto : kInitTakeTitle];
    return cell;
}

- (void)presentInputOnController:(UIViewController *)controller {
    //if the user has no camera, get the photo from saved album
    //if the user has one, give him the choice
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [self presentCameraWithSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    } else {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:[NSString stringWithFormat:@"%@",kPhotoSource] delegate:self cancelButtonTitle:[NSString stringWithFormat:@"%@",kCancel] destructiveButtonTitle:nil otherButtonTitles:[NSString stringWithFormat:@"%@",kChooseFromLibrary], [NSString stringWithFormat:@"%@",kChooseFromCamera] ,nil];
        [actionSheet showInView:controller.view];
    }
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
    __block NSMutableDictionary *metadata;
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];

    switch (picker.sourceType) {
        case UIImagePickerControllerSourceTypeCamera:
        {
            self.image = [info objectForKey:UIImagePickerControllerOriginalImage];

            metadata = [info objectForKey:UIImagePickerControllerMediaMetadata];

            [library writeImageToSavedPhotosAlbum:[self.image CGImage] metadata:metadata completionBlock:^(NSURL *assetURL, NSError *error) {
                if (error) {
                    NSLog(@"Error when saving photo: %@", error.description);
                } else {
                    [self setMetadata:metadata assetURL:assetURL];
                    [self dismissViewController:picker];
                }
            }];

        }
            break;
        case UIImagePickerControllerSourceTypeSavedPhotosAlbum:
        {
            [library assetForURL:[info objectForKey:UIImagePickerControllerReferenceURL]
                 resultBlock:^(ALAsset *asset) {
                     [self.photoData setObject:[asset.defaultRepresentation.url absoluteString] forKey:@"assetURL"];
                     self.image = [QInputPhotoElement UIImageFromAsset:asset resultBlock:^(UIImage *resultImage) {
                         [self setMetadata:asset.defaultRepresentation.metadata assetURL:asset.defaultRepresentation.url];
                         [self dismissViewController:picker];
                     }];
                 }
                failureBlock:^(NSError *error) {
                    NSLog(@"Error while loading file: %@", error.description);
                }];
        }
            break;
        default:
            break;
    }
}

- (void)dismissViewController:(UIViewController *)viewController {
    [viewController dismissViewControllerAnimated:YES completion:^{
        [self.appearance setBackgroundColorEnabled:green_color];
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
