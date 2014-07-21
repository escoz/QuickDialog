//
//  QPhotoViewController.h
//  QuickDialog
//
//  Created by Francis Visoiu Mistrih on 18/07/2014.
//
//

#import <UIKit/UIKit.h>

#import "MEPhotoDataItem.h"

#import "QuickDialog.h"

typedef enum {
    PhotoSourceCamera,
    PhotoSourceBarcode,
    PhotoSourceWeb,
} PhotoSource;

@interface QPhotoViewController : QuickDialogController

@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) NSDictionary *metadata;
@property (strong, nonatomic) MEPhotoDataItem *photoData;

+ (QRootElement *)buildWithImage:(UIImage *)image metadata:(NSDictionary *)metadata photoData:(MEPhotoDataItem *)photoData type:(PhotoSource)type;

- (QPhotoViewController *)initWithPhoto:(UIImage *)image metadata:(NSDictionary *)metadata photoData:(MEPhotoDataItem *)photoData type:(PhotoSource)type;

@end
