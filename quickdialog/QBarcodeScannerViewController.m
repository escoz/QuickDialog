//
//  GlobalBarcodeScannerViewController.m
//  Mobeye
//
//  Created by Francis Visoiu Mistrih on 18/02/2014.
//  Copyright (c) 2014 MobEye. All rights reserved.
//

#import "QBarcodeScannerViewController.h"
#import <ImageIO/CGImageProperties.h>

const NSString *kValidate = @"Valider";
const CGFloat kFlashDuration = 0.4;

@interface QBarcodeScannerViewController ()
{
    //result view
    UIView *whiteView;
    UIImageView *previewImageView;
    UILabel *codeLabel;
    UIButton *validateButton;

    //result data
    UIImage *scannedImage;
    NSString *scannedCode;
    NSDictionary *scannedMetadata;

    //AVFoundation
    AVCaptureSession *session;
    AVCaptureDevice *device;
    AVCaptureDeviceInput *input;
    AVCaptureMetadataOutput *output;
    AVCaptureVideoPreviewLayer *previewCaptureLayer;

    //result image
    AVCaptureStillImageOutput *stillImageOutput;
    BOOL isCapturing;
}

@end

@implementation QBarcodeScannerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    //setup result view
    whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    whiteView.layer.opacity = 0.0f;
    whiteView.layer.backgroundColor = [[UIColor whiteColor] CGColor];
    [self.view addSubview:whiteView];

    previewImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    [previewImageView setContentMode:UIViewContentModeScaleAspectFit];
    previewImageView.hidden = YES;
    [self.view addSubview:previewImageView];

    codeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 80, self.view.bounds.size.width, 40)];
    codeLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    codeLabel.backgroundColor = [UIColor colorWithWhite:0.15 alpha:0.65];
    codeLabel.textColor = [UIColor whiteColor];
    codeLabel.textAlignment = NSTextAlignmentCenter;
    codeLabel.hidden = YES;
    [self.view addSubview:codeLabel];

    validateButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 40, self.view.bounds.size.width, 40)];
    validateButton.backgroundColor = [UIColor colorWithWhite:0.15 alpha:0.65];
    [validateButton setTitle:[NSString stringWithFormat:@"%@",kValidate] forState:UIControlStateNormal];
    validateButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    validateButton.titleLabel.textColor = [UIColor greenColor];
    validateButton.hidden = YES;
    [validateButton addTarget:self action:@selector(didValidateBarcode:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:validateButton];

    stillImageOutput = [[AVCaptureStillImageOutput alloc] init];

    //setup barcode scanner
    //http://www.infragistics.com/community/blogs/torrey-betts/archive/2013/10/10/scanning-barcodes-with-ios-7-objective-c.aspx
    session = [[AVCaptureSession alloc] init];
    device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error;

    input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    if (input) {
        [session addInput:input];
    } else {
        NSLog(@"Error when adding input device: %@", error);
    }

    output = [[AVCaptureMetadataOutput alloc] init];
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    [session addOutput:output];
    output.metadataObjectTypes = [output availableMetadataObjectTypes];

    previewCaptureLayer = [AVCaptureVideoPreviewLayer layerWithSession:session];
    previewCaptureLayer.frame = self.view.bounds;
    previewCaptureLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer:previewCaptureLayer];

    [session addOutput:stillImageOutput];
    [session startRunning];

    isCapturing = NO;
    [self.view bringSubviewToFront:codeLabel];
    [self.view bringSubviewToFront:validateButton];
}

- (void)flashScreen {
    [self.view bringSubviewToFront:whiteView];
    CAKeyframeAnimation *opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    NSArray *animationValues = @[ @0.8f, @0.0f ];
    NSArray *animationTimes = @[ @0.3f, @1.0f ];
    id timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    NSArray *animationTimingFunctions = @[ timingFunction, timingFunction ];
    [opacityAnimation setValues:animationValues];
    [opacityAnimation setKeyTimes:animationTimes];
    [opacityAnimation setTimingFunctions:animationTimingFunctions];
    opacityAnimation.fillMode = kCAFillModeForwards;
    opacityAnimation.removedOnCompletion = YES;
    opacityAnimation.duration = kFlashDuration;

    [whiteView.layer addAnimation:opacityAnimation forKey:@"animation"];
}

- (void)didValidateBarcode:(id)sender {
    [self.delegate barcodeScanner:self didFinishScanningWithImage:scannedImage andMetadata:scannedMetadata andResult:scannedCode];
}

- (void)captureStillImageWithMetadata:(id)metadata {
    //http://stackoverflow.com/questions/13106486/how-to-save-photos-taken-using-avfoundation-to-photo-album
    AVCaptureConnection *videoConnection = nil;
    for (AVCaptureConnection *connection in stillImageOutput.connections) {
        for (AVCaptureInputPort *port in [connection inputPorts]) {
            if ([[port mediaType] isEqual:AVMediaTypeVideo] ) {
                videoConnection = connection;
                break;
            }
        }
        if (videoConnection) break;
    }

    NSLog(@"About to request a capture from: %@", stillImageOutput);
    [stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection
                                                  completionHandler: ^(CMSampleBufferRef imageSampleBuffer, NSError *error)
     {
         //check for the buffer
         //http://stackoverflow.com/questions/8452072/why-does-avcapturestillimageoutput-jpegstillimagensdatarepresentation-throw-an-e
         if (CMSampleBufferIsValid(imageSampleBuffer)) {
             NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
             UIImage *image = [[UIImage alloc] initWithData:imageData];

             //can't return a UIImage, because the capture is asynchronous
             scannedImage = image;

             //release the camera preview layer
             [previewCaptureLayer removeFromSuperlayer];
             previewCaptureLayer = nil;

             CFDictionaryRef exifMetadata = CMGetAttachment(imageSampleBuffer, kCGImagePropertyExifDictionary, NULL);
             scannedMetadata = (__bridge NSDictionary *)exifMetadata;;
             scannedCode = [metadata stringValue];
             [self didSuccessfulyScanBarcodeWithImage:image];

             [session stopRunning];
             isCapturing = NO;
         }
     }];
}

- (void)didSuccessfulyScanBarcodeWithImage:(UIImage *)image {
    [self flashScreen];
    previewImageView.hidden = NO;
    previewImageView.image = image;

    codeLabel.hidden = NO;
    codeLabel.text = scannedCode;
    validateButton.hidden = NO;
}

#pragma mark AVCaptureMetadataOutputObjectsDelegate methods

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    AVMetadataMachineReadableCodeObject *barCodeObject;
    NSString *detectionString;
    NSArray *barCodeTypes = @[AVMetadataObjectTypeUPCECode, AVMetadataObjectTypeCode39Code, AVMetadataObjectTypeCode39Mod43Code,
                              AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode93Code, AVMetadataObjectTypeCode128Code,
                              AVMetadataObjectTypePDF417Code, AVMetadataObjectTypeQRCode, AVMetadataObjectTypeAztecCode];

    for (AVMetadataObject *metadata in metadataObjects) {
        for (NSString *type in barCodeTypes) {
            if ([metadata.type isEqualToString:type])
            {
                barCodeObject = (AVMetadataMachineReadableCodeObject *)[previewCaptureLayer transformedMetadataObjectForMetadataObject:(AVMetadataMachineReadableCodeObject *)metadata];
                detectionString = [(AVMetadataMachineReadableCodeObject *)metadata stringValue];
                break;
            }
        }

        //check if the camera is capturing
        //the still image is rendered asynchronously
        //don't launch another capture if there is one in progress
        //when calling captureStillImage the view is popped, so the capture is not launched again
        if (detectionString && !isCapturing) {
            isCapturing = YES;
            //we got a result, now take a photo and call delegate methods
            [self captureStillImageWithMetadata:metadata];
            break;
        }
    }
}

@end
