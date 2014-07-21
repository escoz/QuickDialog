//
//  QBarcodeElement.h
//  QuickDialog
//
//  Created by Francis Visoiu Mistrih on 17/07/2014.
//
//

#import "QTakePhotoElement.h"
#import "QBarcodeScannerViewController.h"

@interface QBarcodeElement : QButtonElement<QBarcodeScannerPickerDelegate>

@property (strong, nonatomic) MEPhotoDataItem *photoData;

@end
