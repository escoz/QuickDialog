//
//  QPhotoElement.h
//  QuickDialog
//
//  Created by Francis Visoiu Mistrih on 16/07/2014.
//
//

#import "QButtonElement.h"

@interface QPhotoElement : QButtonElement <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (strong, nonatomic) UIImage *image;

@property BOOL isPhotoTaken;

@end
