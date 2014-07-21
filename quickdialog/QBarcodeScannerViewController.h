//
//  GlobalBarcodeScannerViewController.h
//  Mobeye
//
//  Created by Francis Visoiu Mistrih on 18/02/2014.
//  Copyright (c) 2014 MobEye. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@class QBarcodeScannerViewController;

@protocol QBarcodeScannerPickerDelegate <NSObject>

- (void)barcodeScanner:(QBarcodeScannerViewController *)barcodeScanner didFinishScanningWithImage:(UIImage *)image andMetadata:(NSDictionary *)metadata andResult:(NSDictionary *)result;

@end

@interface QBarcodeScannerViewController : UIViewController <AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, assign) id<QBarcodeScannerPickerDelegate> delegate;

@end
