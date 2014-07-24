//
//  QTakePhotoElement.m
//  QuickDialog
//
//  Created by Francis Visoiu Mistrih on 16/07/2014.
//
//

#import "QTakePhotoElement.h"
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <AssetsLibrary/ALAssetRepresentation.h>

#define green_color [UIColor colorWithRed:0.373 green:0.878 blue:0.471 alpha:1]
const NSString *kInitTakeTitle = @"Prendre photo";
const NSString *kPreviewTakeTitle = @"Voir photo";
const NSString *kPhotoSource = @"Source photo";
const NSString *kCancelActionSheet = @"Annuler";
const NSString *kChooseFromLibrary = @"Choisir une photo";
const NSString *kChooseFromCamera = @"Prendre une photo";

@implementation QTakePhotoElement

- (QTakePhotoElement *)init
{
    self = [super init];
    if (self) {
        [self initPhotoData];
        self.appearance = [self.appearance copy];
    }
    return self;
}

- (void)initPhotoData {
    _photoData = [NSMutableDictionary dictionary];
}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {
    QTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuickformPhotoElement"];
    if (cell == nil){
        cell = [[QTableViewCell alloc] initWithReuseIdentifier:@"QuickformPhotoElement"];
    }
    [cell applyAppearanceForElement:self];

    cell.textLabel.text = [NSString stringWithFormat:@"%@", [_photoData[@"isPhotoTaken"] boolValue] ? kPreviewTakeTitle : kInitTakeTitle];
    return cell;
}

- (void)selected:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller indexPath:(NSIndexPath *)indexPath {
    if ([_photoData[@"isPhotoTaken"] boolValue]) {
        //show the photo to the user
        //create a new image regarding its orientation
        //http://stackoverflow.com/questions/8915630/ios-uiimageview-how-to-handle-uiimage-image-orientation
        UIImage *rotatedImage = [UIImage imageWithCGImage:[self.image CGImage] scale:1.0 orientation:[_photoData[@"metadata"][@"Orientation"] integerValue]];
        QPhotoViewController *vc = [[QPhotoViewController alloc] initWithPhoto:rotatedImage photoData:_photoData type:PhotoSourceCamera];
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

+ (UIImage *)UIImageFromAsset:(ALAsset *)asset resultBlock:(void(^)(UIImage *resultImage))resultBlock {
    UIImage *image;
    ALAssetRepresentation *rep = [asset defaultRepresentation];
    CGImageRef iref = [rep fullResolutionImage];
    if (iref) {
        image = [UIImage imageWithCGImage:iref];
        resultBlock(image);
    }

    //return the image if successful
    //return nil if not

    if (!image)
        NSLog(@"Error while transforming ALAsset in UIImage.");

    return image;
}

- (void)setMetadata:(NSDictionary *)metadata assetURL:(NSURL *)assetURL {
    if (metadata) {
        [_photoData setObject:[assetURL absoluteString] forKey:@"assetURL"];
        [_photoData setObject:metadata forKey:@"metadata"];
        //set the isPhotoTaken flag here, so pictures without metadata won't be allowed
        [_photoData setObject:[NSNumber numberWithBool:YES] forKey:@"isPhotoTaken"];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Erreur" message:@"La photo selectionnée n'est pas conforme aux règles Mobeye." delegate:self cancelButtonTitle:[NSString stringWithFormat:@"%@",kCancelActionSheet] otherButtonTitles:nil];
        [alert show];
    }
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
                }
            }];

        }
            break;
        case UIImagePickerControllerSourceTypeSavedPhotosAlbum:
        {
            [library assetForURL:[info objectForKey:UIImagePickerControllerReferenceURL]
                 resultBlock:^(ALAsset *asset) {
                     [_photoData setObject:[asset.defaultRepresentation.url absoluteString] forKey:@"assetURL"];
                     self.image = [QTakePhotoElement UIImageFromAsset:asset resultBlock:^(UIImage *resultImage) {
                         [self setMetadata:asset.defaultRepresentation.metadata assetURL:asset.defaultRepresentation.url];
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

    [picker dismissViewControllerAnimated:YES completion:^{
        [[(QuickDialogController *)self.controller quickDialogTableView] reloadCellForElements:self, nil];
    }];
}

- (void)bindToObject:(id)data shallow:(BOOL)shallow {
    [super bindToObject:data shallow:shallow];

    //when no json data comes in, the binding sets photoData to nil.
    //Init it again if that's the case
    if (!_photoData) [self initPhotoData];

    if (_photoData[@"assetURL"]) {
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        [library assetForURL:[NSURL URLWithString:_photoData[@"assetURL"]]
                 resultBlock:^(ALAsset *asset) {
                     self.image = [QTakePhotoElement UIImageFromAsset:asset resultBlock:^(UIImage *resultImage) {
                         [self.appearance setBackgroundColorEnabled:green_color];
                         //[[(QuickDialogController *)self.controller quickDialogTableView] reloadCellForElements:self, nil];

                     }];
                 }
                failureBlock:^(NSError *error) {
                    NSLog(@"Error while loading photo: %@",error.description);
                }];
    }
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
