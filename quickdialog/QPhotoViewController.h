//
//  QPhotoViewController.h
//  QuickDialog
//
//  Created by Francis Visoiu Mistrih on 18/07/2014.
//
//

#import <UIKit/UIKit.h>
#import "QuickDialog.h"

typedef enum {
    PhotoSourceCamera,
    PhotoSourceBarcode,
    PhotoSourceWeb,
} PhotoSource;

@interface QPhotoViewController : QuickDialogController

@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) NSDictionary *metadata;

+ (QRootElement *)buildWithImage:(UIImage *)image metadata:(NSDictionary *)metadata type:(PhotoSource)type;

- (QPhotoViewController *)initWithPhoto:(UIImage *)image metadata:(NSDictionary *)metadata type:(PhotoSource)type;

@end
