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

@end
