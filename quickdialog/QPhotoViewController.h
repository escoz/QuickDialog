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

@property (strong, nonatomic) NSMutableDictionary *photoData;

@property (strong, nonatomic) QButtonElement *element;

+ (QRootElement *)buildWithPhoto:(UIImage *)photo photoData:(NSMutableDictionary *)photoData type:(PhotoSource)type;

- (QPhotoViewController *)initWithPhoto:(UIImage *)photo photoData:(NSMutableDictionary *)photoData type:(PhotoSource)type;

@end
