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
        self.takeTitle = [NSString stringWithFormat:@"%@", kInitScanTitle];
    }
    return self;
}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {
    QTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuickformPhotoElement"];
    if (cell == nil){
        cell = [[QTableViewCell alloc] init];
    }
    [cell applyAppearanceForElement:self];

    NSString *result = _productName && _productBrand ? [_productBrand stringByAppendingString:[NSString stringWithFormat:@" %@",_productName]] : _code;
    cell.textLabel.text = self.isPhotoTaken ? [NSString stringWithFormat:@"%@ : %@",self.previewTitle, result] : self.takeTitle;
    return cell;
}

- (void)selected:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller indexPath:(NSIndexPath *)indexPath {
    if (self.isPhotoTaken) {
        //show the photo to the user
        QPhotoViewController *vc = [[QPhotoViewController alloc] initWithPhoto:_image metadata:self.metadata type:PhotoSourceBarcode];
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
    self.image = image;
    self.metadata = [NSMutableDictionary dictionaryWithDictionary:metadata];
    self.code = result[@"code"];
    self.productBrand = result[@"product_brand"];
    self.productName = result[@"product_name"];

    //use the metadata entries to add the results from the barcode
    [self.metadata addEntriesFromDictionary:@{@"code":_code, @"product_brand":_productBrand, @"product_name":_productName}];

    self.isPhotoTaken = YES;
    [barcodeScanner dismissViewControllerAnimated:YES completion:^{
        [[(QuickDialogController *)self.controller quickDialogTableView] reloadCellForElements:self, nil];
    }];
}

@end
