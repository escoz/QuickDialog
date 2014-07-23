//
//  QBarcodeElement.m
//  QuickDialog
//
//  Created by Francis Visoiu Mistrih on 17/07/2014.
//
//

#import "QBarcodeElement.h"
#import "QPhotoViewController.h"

#define green_color [UIColor colorWithRed:0.373 green:0.878 blue:0.471 alpha:1]
const NSString *kInitScanTitle = @"Scannez le code barres";

@implementation QBarcodeElement

- (QBarcodeElement *)init
{
    self = [super init];
    if (self) {
        _photoData = [NSMutableDictionary dictionary];
        [_photoData setObject:[NSString stringWithFormat:@"%@",kInitScanTitle] forKey:@"takeTitle"];
        self.appearance = [self.appearance copy];
    }
    return self;
}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {
    QTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuickformPhotoElement"];
    if (cell == nil){
        cell = [[QTableViewCell alloc] init];
    }
    [cell applyAppearanceForElement:self];

    NSString *result = _photoData[@"productName"] && _photoData[@"productBrand"] ? [_photoData[@"productBrand"] stringByAppendingString:[NSString stringWithFormat:@" %@",_photoData[@"productName"]]] : _photoData[@"code"];
    cell.textLabel.text = [_photoData[@"isPhotoTaken"] boolValue] ? [NSString stringWithFormat:@"%@ : %@",_photoData[@"previewTitle"], result] : _photoData[@"takeTitle"];
    return cell;
}

- (void)selected:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller indexPath:(NSIndexPath *)indexPath {
    if ([_photoData[@"isPhotoTaken"] boolValue]) {
        //show the photo to the user
        QPhotoViewController *vc = [[QPhotoViewController alloc] initWithPhoto:self.image photoData:_photoData type:PhotoSourceBarcode];
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

- (void)barcodeScanner:(QBarcodeScannerViewController *)barcodeScanner didFinishScanningWithImage:(UIImage *)image andMetadata:(NSDictionary *)metadata andResult:(NSDictionary *)result {
    self.image = image;

    for (NSString *key in [result allKeys]) {
        [_photoData setObject:result[key] forKey:key];
    }
    [_photoData setObject:[NSNumber numberWithBool:YES] forKey:@"isPhotoTaken"];

    [barcodeScanner dismissViewControllerAnimated:YES completion:^{
        [self.appearance setBackgroundColorEnabled:green_color];
        [[(QuickDialogController *)self.controller quickDialogTableView] reloadCellForElements:self, nil];
    }];
}

- (void)barcodeScanner:(QBarcodeScannerViewController *)barcodeScanner didCancelScanning:(id)sender {
    [barcodeScanner dismissViewControllerAnimated:YES completion:nil];
}

@end
