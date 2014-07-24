//
//  QBarcodeElement.h
//  QuickDialog
//
//  Created by Francis Visoiu Mistrih on 17/07/2014.
//
//

#import "QTakePhotoElement.h"

#import "QInputPhotoElement.h"
#import "QBarcodeScannerViewController.h"

@interface QBarcodeElement : QInputPhotoElement<QBarcodeScannerPickerDelegate>

@end
