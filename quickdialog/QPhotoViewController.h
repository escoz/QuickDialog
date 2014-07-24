//
//  QPhotoViewController.h
//  QuickDialog
//
//  Created by Francis Visoiu Mistrih on 18/07/2014.
//
//

#import <UIKit/UIKit.h>

#import "QuickDialog.h"

@interface QPhotoViewController : QuickDialogController

@property (strong, nonatomic) NSMutableDictionary *photoData;

@property (strong, nonatomic) QButtonElement *element;

+ (QRootElement *)buildWithPhoto:(UIImage *)photo photoData:(NSMutableDictionary *)photoData;

- (QPhotoViewController *)initWithPhoto:(UIImage *)photo photoData:(NSMutableDictionary *)photoData;

@end
