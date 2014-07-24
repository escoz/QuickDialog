//
//  QBarcodeElement.m
//  QuickDialog
//
//  Created by Francis Visoiu Mistrih on 17/07/2014.
//
//

#import "QBarcodeElement.h"
#import "QPhotoViewController.h"
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <AssetsLibrary/ALAssetRepresentation.h>

#define green_color [UIColor colorWithRed:0.373 green:0.878 blue:0.471 alpha:1]
const NSString *kInitScanTitle = @"Scannez le code barres";
const NSString *kInitPreviewTitle = @"Voir photo";

@implementation QBarcodeElement

- (QBarcodeElement *)init
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
        cell = [[QTableViewCell alloc] init];
    }
    [cell applyAppearanceForElement:self];
    NSString *result = _photoData[@"product_name"] && _photoData[@"product_brand"] ? [NSString stringWithFormat:@"%@ : %@",_photoData[@"product_brand"] ,_photoData[@"product_name"]] : _photoData[@"code"];
    NSString *preview = [NSString stringWithFormat:@"%@ : %@", kInitPreviewTitle, result];

    cell.textLabel.text = [_photoData[@"isPhotoTaken"] boolValue] ? preview : [NSString stringWithFormat:@"%@",kInitScanTitle];
    return cell;
}

- (void)selected:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller indexPath:(NSIndexPath *)indexPath {
    if ([_photoData[@"isPhotoTaken"] boolValue]) {
        //show the photo to the user
        //create a new image regarding its orientation
        //http://stackoverflow.com/questions/8915630/ios-uiimageview-how-to-handle-uiimage-image-orientation
        UIImage *rotatedImage = [UIImage imageWithCGImage:[self.image CGImage] scale:1.0 orientation:[_photoData[@"metadata"][@"Orientation"] integerValue]];
        QPhotoViewController *vc = [[QPhotoViewController alloc] initWithPhoto:rotatedImage photoData:_photoData type:PhotoSourceBarcode];
        vc.element = self;
        [controller.navigationController pushViewController:vc animated:YES];
    } else {
        //get the barcode
        QBarcodeScannerViewController *picker = [[QBarcodeScannerViewController alloc] init];
        picker.delegate = self;
        [controller presentViewController:picker animated:YES completion:nil];
    }

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
    [_photoData setObject:[assetURL absoluteString] forKey:@"assetURL"];
    [_photoData setObject:metadata forKey:@"metadata"];
    //set the isPhotoTaken flag here, so pictures without metadata won't be allowed
    [_photoData setObject:[NSNumber numberWithBool:YES] forKey:@"isPhotoTaken"];
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
                     self.image = [QBarcodeElement UIImageFromAsset:asset resultBlock:^(UIImage *resultImage) {
                         [self.appearance setBackgroundColorEnabled:green_color];
                     }];
                 }
                failureBlock:^(NSError *error) {
                    NSLog(@"Error while loading photo: %@",error.description);
                }];
    }
}

- (void)barcodeScanner:(QBarcodeScannerViewController *)barcodeScanner didFinishScanningWithImage:(UIImage *)image andMetadata:(NSDictionary *)metadata andResult:(NSDictionary *)result {
    self.image = image;

    for (NSString *key in [result allKeys]) {
        [_photoData setObject:result[key] forKey:key];
    }

    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library writeImageToSavedPhotosAlbum:[self.image CGImage] metadata:metadata completionBlock:^(NSURL *assetURL, NSError *error) {
        if (error) {
            NSLog(@"Error when saving photo: %@", error.description);
        } else {
            [self setMetadata:metadata assetURL:assetURL];
            [barcodeScanner dismissViewControllerAnimated:YES completion:^{
                [self.appearance setBackgroundColorEnabled:green_color];
                [[(QuickDialogController *)self.controller quickDialogTableView] reloadCellForElements:self, nil];
            }];
        }
    }];
}

- (void)barcodeScanner:(QBarcodeScannerViewController *)barcodeScanner didCancelScanning:(id)sender {
    [barcodeScanner dismissViewControllerAnimated:YES completion:nil];
}

@end
