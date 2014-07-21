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

@property (strong, nonatomic) MEPhotoDataItem *photoData;

+ (QRootElement *)buildWithPhotoData:(MEPhotoDataItem *)photoData type:(PhotoSource)type;

- (QPhotoViewController *)initWithPhotoData:(MEPhotoDataItem *)photoData type:(PhotoSource)type;

@end
