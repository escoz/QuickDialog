//
//  QTakePhotoElement.h
//  QuickDialog
//
//  Created by Francis Visoiu Mistrih on 16/07/2014.
//
//

#import "QButtonElement.h"

@interface QTakePhotoElement : QButtonElement <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate>

@property (strong, nonatomic) NSMutableDictionary *photoData;

@end
