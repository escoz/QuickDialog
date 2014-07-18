//
//  QPhotoElement.h
//  QuickDialog
//
//  Created by Francis Visoiu Mistrih on 18/07/2014.
//
//

#import "QRootElement.h"

@interface QPhotoElement : QRootElement

@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) NSString *url;
@property float height;

- (QPhotoElement *)initWithImage:(UIImage *)image;

- (QPhotoElement *)initWithURL:(NSString *)url;

@end
