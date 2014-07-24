//
//  QInputPhotoElement.h
//  Mobeye
//
//  Created by Francis Visoiu Mistrih on 24/07/2014.
//  Copyright (c) 2014 MobEye. All rights reserved.
//

#import "QButtonElement.h"
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <AssetsLibrary/ALAssetRepresentation.h>

#define green_color [UIColor colorWithRed:0.373 green:0.878 blue:0.471 alpha:1]

extern NSString *const kPreviewPhoto;
extern NSString *const kPhotoSource;
extern NSString *const kCCancel;

@interface QInputPhotoElement : QButtonElement

@property (strong, nonatomic) NSMutableDictionary *photoData;

- (void)presentInputOnController:(UIViewController *)controller;

+ (UIImage *)UIImageFromAsset:(ALAsset *)asset resultBlock:(void(^)(UIImage *resultImage))resultBlock;

- (void)setMetadata:(NSDictionary *)metadata assetURL:(NSURL *)assetURL;

@end
