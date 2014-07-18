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

    cell.textLabel.text = self.isPhotoTaken ? [NSString stringWithFormat:@"%@ : %@",self.previewTitle, _code] : self.takeTitle;
    return cell;
}

- (void)selected:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller indexPath:(NSIndexPath *)indexPath {
    if (self.isPhotoTaken) {
        //show the photo to the user
        QPhotoViewController *vc = [[QPhotoViewController alloc] initWithPhoto:_image andType:PhotoSourceBarcode];
        [controller.navigationController pushViewController:vc animated:YES];
    } else {
        //get the barcode
        QBarcodeScannerViewController *picker = [[QBarcodeScannerViewController alloc] init];
        picker.delegate = self;
        [controller presentViewController:picker animated:YES completion:nil];
    }

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)barcodeScanner:(QBarcodeScannerViewController *)barcodeScanner didFinishScanningWithImage:(UIImage *)image andMetadata:(NSDictionary *)metadata andResult:(NSString *)result {
    self.image = image;
    self.metadata = metadata;
    self.code = result;
    self.isPhotoTaken = YES;
    [barcodeScanner dismissViewControllerAnimated:YES completion:^{
        [[(QuickDialogController *)self.controller quickDialogTableView] reloadCellForElements:self, nil];
    }];
}

@end
