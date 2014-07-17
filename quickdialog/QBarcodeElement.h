//
//  QBarcodeElement.h
//  QuickDialog
//
//  Created by Francis Visoiu Mistrih on 17/07/2014.
//
//

#import "QPhotoElement.h"
#import "QBarcodeScannerViewController.h"

@interface QBarcodeElement : QPhotoElement<QBarcodeScannerPickerDelegate>

@property (strong,nonatomic) NSString *code;

@end
