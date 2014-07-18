//
//  GlobalBarcodeScannerViewController.m
//  Mobeye
//
//  Created by Francis Visoiu Mistrih on 18/02/2014.
//  Copyright (c) 2014 MobEye. All rights reserved.
//

#import "QBarcodeScannerViewController.h"
#import <ImageIO/CGImageProperties.h>

@interface QBarcodeScannerViewController ()
{
    //result view
    UIView *whiteScreen;
    UIImageView *previewImageView;
    UILabel *codeLabel;
    UIButton *validateButton;

    //result data
    UIImage *scannedImage;
    NSString *scannedCode;
    NSDictionary *scannedMetadata;

    //AVFoundation
    AVCaptureSession *_session;
    AVCaptureDevice *_device;
    AVCaptureDeviceInput *_input;
    AVCaptureMetadataOutput *_output;
    AVCaptureVideoPreviewLayer *_prevLayer;
    UIView *targetView;

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
    whiteScreen = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    whiteScreen.layer.opacity = 0.0f;
    whiteScreen.layer.backgroundColor = [[UIColor whiteColor] CGColor];
    [self.navigationController.view addSubview:whiteScreen];

    previewImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    [previewImageView setContentMode:UIViewContentModeScaleAspectFit];
    previewImageView.hidden = YES;
    [self.view addSubview:previewImageView];

    codeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 80, self.view.bounds.size.width, 40)];
    codeLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    codeLabel.backgroundColor = [UIColor colorWithWhite:0.15 alpha:0.65];
    codeLabel.textColor = [UIColor whiteColor];
    codeLabel.textAlignment = NSTextAlignmentCenter;
    codeLabel.text = @"";
    codeLabel.hidden = YES;
    [self.view addSubview:codeLabel];

    validateButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 40, self.view.bounds.size.width, 40)];
    validateButton.backgroundColor = [UIColor colorWithWhite:0.15 alpha:0.65];
    [validateButton setTitle:@"Valider" forState:UIControlStateNormal];
    validateButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    validateButton.titleLabel.textColor = [UIColor redColor];
    validateButton.hidden = YES;
    [validateButton addTarget:self action:@selector(didValidateBarcode:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:validateButton];

    stillImageOutput = [[AVCaptureStillImageOutput alloc] init];

    //setup native barcode scanner
    //http://www.infragistics.com/community/blogs/torrey-betts/archive/2013/10/10/scanning-barcodes-with-ios-7-objective-c.aspx
    _session = [[AVCaptureSession alloc] init];
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = nil;

    _input = [AVCaptureDeviceInput deviceInputWithDevice:_device error:&error];
    if (_input) {
        [_session addInput:_input];
    } else {
        NSLog(@"Error: %@", error);
    }

    _output = [[AVCaptureMetadataOutput alloc] init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    [_session addOutput:_output];

    _output.metadataObjectTypes = [_output availableMetadataObjectTypes];

    _prevLayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    _prevLayer.frame = self.view.bounds;
    _prevLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer:_prevLayer];

    /*
    CGRect windowSize = _prevLayer.frame;
    CGSize targetSize = CGSizeMake(150, 200);
    targetView = [[UIView alloc] initWithFrame:CGRectMake(windowSize.size.width / 2 - targetSize.width /2, windowSize.size.height / 2 - targetSize.height / 2, targetSize.width, targetSize.height)];
    targetView.layer.borderWidth = 3.0;
    targetView.layer.borderColor = [[UIColor greenColor] CGColor];
    [self.view addSubview:targetView];
     */

    [_session addOutput:stillImageOutput];

    [_session startRunning];

    isCapturing = NO;
    [self.view bringSubviewToFront:codeLabel];
    [self.view bringSubviewToFront:validateButton];
}

- (void)flashScreen {
    [self.navigationController.view bringSubviewToFront:whiteScreen];
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
    opacityAnimation.duration = 0.6;

    [whiteScreen.layer addAnimation:opacityAnimation forKey:@"animation"];
}

- (void)didValidateBarcode:(id)sender {
    [self.delegate barcodeScanner:self didFinishScanningWithImage:scannedImage andMetadata:scannedMetadata andResult:scannedCode];
}

- (void)captureStillImageWithMetadata:(id)metadata {
    //http://stackoverflow.com/questions/13106486/how-to-save-photos-taken-using-avfoundation-to-photo-album
    AVCaptureConnection *videoConnection = nil;
    for (AVCaptureConnection *connection in stillImageOutput.connections)
    {
        for (AVCaptureInputPort *port in [connection inputPorts])
        {
            if ([[port mediaType] isEqual:AVMediaTypeVideo] )
            {
                videoConnection = connection;
                break;
            }
        }
        if (videoConnection) { break; }
    }

    NSLog(@"about to request a capture from: %@", stillImageOutput);
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

             [_prevLayer removeFromSuperlayer];
             _prevLayer = nil;

             CFDictionaryRef exifMetadata = CMGetAttachment(imageSampleBuffer, kCGImagePropertyExifDictionary, NULL);
             scannedMetadata = (__bridge NSDictionary *)exifMetadata;;
             scannedCode = [metadata stringValue];

             [self didSuccessfulyScanBarcodeWithImage:image];

             [_session stopRunning];

             isCapturing = NO;
         }
     }];
}

- (void)didSuccessfulyScanBarcodeWithImage:(UIImage *)image {
    [self flashScreen];
    previewImageView.hidden = NO;
    [previewImageView setImage:image];

    codeLabel.hidden = NO;
    codeLabel.text = scannedCode;
    validateButton.hidden = NO;
}

#pragma mark AVCaptureMetadataOutputObjectsDelegate methods

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    AVMetadataMachineReadableCodeObject *barCodeObject;
    NSString *detectionString = nil;
    NSArray *barCodeTypes = @[AVMetadataObjectTypeUPCECode, AVMetadataObjectTypeCode39Code, AVMetadataObjectTypeCode39Mod43Code,
                              AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode93Code, AVMetadataObjectTypeCode128Code,
                              AVMetadataObjectTypePDF417Code, AVMetadataObjectTypeQRCode, AVMetadataObjectTypeAztecCode];

    for (AVMetadataObject *metadata in metadataObjects) {
        for (NSString *type in barCodeTypes) {
            if ([metadata.type isEqualToString:type])
            {
                barCodeObject = (AVMetadataMachineReadableCodeObject *)[_prevLayer transformedMetadataObjectForMetadataObject:(AVMetadataMachineReadableCodeObject *)metadata];
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
