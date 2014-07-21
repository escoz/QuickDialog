//
//  QBarcodeElement.h
//  QuickDialog
//
//  Created by Francis Visoiu Mistrih on 17/07/2014.
//
//

#import "QTakePhotoElement.h"
#import "QBarcodeScannerViewController.h"

@interface QBarcodeElement : QTakePhotoElement<QBarcodeScannerPickerDelegate>

@property (strong,nonatomic) NSString *code;
@property (strong,nonatomic) NSString *productBrand;
@property (strong,nonatomic) NSString *productName;

@end
