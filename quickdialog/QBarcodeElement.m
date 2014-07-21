//
//  QBarcodeElement.m
//  QuickDialog
//
//  Created by Francis Visoiu Mistrih on 17/07/2014.
//
//

#import "QBarcodeElement.h"
#import "QPhotoViewController.h"

const NSString *kInitScanTitle = @"Scannez le code barres";

@implementation QBarcodeElement

- (QBarcodeElement *)init
{
    self = [super init];
    if (self) {
        _photoData = [[MEPhotoDataItem alloc] init];
        _photoData.takeTitle = [NSString stringWithFormat:@"%@", kInitScanTitle];
    }
    return self;
}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {
    QTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuickformPhotoElement"];
    if (cell == nil){
        cell = [[QTableViewCell alloc] init];
    }
    [cell applyAppearanceForElement:self];

    NSString *result = _photoData.productName && _photoData.productBrand ? [_photoData.productBrand stringByAppendingString:[NSString stringWithFormat:@" %@",_photoData.productName]] : _photoData.code;
    cell.textLabel.text = _photoData.isPhotoTaken ? [NSString stringWithFormat:@"%@ : %@",_photoData.previewTitle, result] : _photoData.takeTitle;
    return cell;
}

- (void)selected:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller indexPath:(NSIndexPath *)indexPath {
    if (_photoData.isPhotoTaken) {
        //show the photo to the user
        QPhotoViewController *vc = [[QPhotoViewController alloc] initWithPhoto:_photoData.image metadata:_photoData.metadata photoData:_photoData type:PhotoSourceBarcode];
        [controller.navigationController pushViewController:vc animated:YES];
    } else {
        //get the barcode
        QBarcodeScannerViewController *picker = [[QBarcodeScannerViewController alloc] init];
        picker.delegate = self;
        [controller presentViewController:picker animated:YES completion:nil];
    }

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)barcodeScanner:(QBarcodeScannerViewController *)barcodeScanner didFinishScanningWithImage:(UIImage *)image andMetadata:(NSDictionary *)metadata andResult:(NSDictionary *)result {
    _photoData.image = image;
    _photoData.metadata = [NSMutableDictionary dictionaryWithDictionary:metadata];
    _photoData.code = result[@"code"];
    _photoData.productBrand = result[@"product_brand"];
    _photoData.productName = result[@"product_name"];
    _photoData.isPhotoTaken = YES;

    [barcodeScanner dismissViewControllerAnimated:YES completion:^{
        [[(QuickDialogController *)self.controller quickDialogTableView] reloadCellForElements:self, nil];
    }];
}

@end
