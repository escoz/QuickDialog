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

+ (QRootElement *)buildWithImage:(UIImage *)image andType:(PhotoSource)type;

- (QPhotoViewController *)initWithPhoto:(UIImage *)image andType:(PhotoSource)type;

@end
