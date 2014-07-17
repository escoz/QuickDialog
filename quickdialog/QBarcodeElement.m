//
//  QBarcodeElement.m
//  QuickDialog
//
//  Created by Francis Visoiu Mistrih on 17/07/2014.
//
//

#import "QBarcodeElement.h"

@implementation QBarcodeElement

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {
    QTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuickformPhotoElement"];
    if (cell == nil){
        cell = [[QTableViewCell alloc] init];
    }
    [cell applyAppearanceForElement:self];

    //[cell.imageView setImage:_image ? _image : [UIImage imageNamed:@"icon"]];
    cell.textLabel.text = self.isPhotoTaken ? [NSString stringWithFormat:@"Voir image : %@",_code] : @"Scannez le code barres";
    return cell;
}

- (void)selected:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller indexPath:(NSIndexPath *)indexPath {
    if (self.isPhotoTaken) {
        //show the photo to the user
        UIViewController *vc = [[UIViewController alloc] init];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:controller.view.frame];
        [imageView setContentMode:UIViewContentModeScaleAspectFit];
        [imageView setImage:_image];
        [vc.view addSubview:imageView];
        [controller.navigationController pushViewController:vc animated:YES];
    } else {
        //get the barcode
        QBarcodeScannerViewController *picker = [[QBarcodeScannerViewController alloc] init];
#warning to change to self.controller
        picker.delegate = self;
        [controller presentViewController:picker animated:YES completion:nil];
    }

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)barcodeScanner:(QBarcodeScannerViewController *)barcodeScanner didFinishScanningWithImage:(UIImage *)image andMetadata:(NSDictionary *)metadata andResult:(NSString *)result {
    self.image = image;
    self.code = result;
    self.isPhotoTaken = YES;
    [barcodeScanner dismissViewControllerAnimated:YES completion:^{
        [[(QuickDialogController *)self.controller quickDialogTableView] reloadCellForElements:self, nil];
    }];
}

@end
