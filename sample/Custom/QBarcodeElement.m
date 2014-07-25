//
//  QBarcodeElement.m
//  QuickDialog
//
//  Created by Francis Visoiu Mistrih on 17/07/2014.
//
//

#import "QBarcodeElement.h"

#import <AssetsLibrary/ALAssetsLibrary.h>
#import <AssetsLibrary/ALAssetRepresentation.h>

#import "QPhotoViewController.h"

const NSString *kInitScanTitle = @"Scannez le code barres";

@implementation QBarcodeElement

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {
    QTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuickformPhotoElement"];
    if (cell == nil){
        cell = [[QTableViewCell alloc] init];
    }
    [cell applyAppearanceForElement:self];

    //create a string according to the product name, brand and scanned code
    NSString *resultString = self.photoData[@"product_name"] && self.photoData[@"product_brand"] ? [NSString stringWithFormat:@"%@ : %@",self.photoData[@"product_brand"] ,self.photoData[@"product_name"]] : self.photoData[@"code"];
    NSString *previewString = [NSString stringWithFormat:@"%@ : %@", kPreviewPhoto, resultString];
    cell.textLabel.text = [self.photoData[@"isPhotoTaken"] boolValue] ? previewString : [NSString stringWithFormat:@"%@",kInitScanTitle];

    return cell;
}

- (void)presentInputOnController:(UIViewController *)controller {
    //get the barcode scanned
    QBarcodeScannerViewController *picker = [[QBarcodeScannerViewController alloc] init];
    picker.delegate = self;
    [controller presentViewController:picker animated:YES completion:nil];
}

#pragma mark QBarcodeScannerPicker delegate

- (void)barcodeScanner:(QBarcodeScannerViewController *)barcodeScanner didFinishScanningWithImage:(UIImage *)image andMetadata:(NSDictionary *)metadata andResult:(NSDictionary *)result {
    self.image = image;

    //result contains code, product_brand and product_name
    //set all those in the photoData
    for (NSString *key in [result allKeys]) {
        [self.photoData setObject:result[key] forKey:key];
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
