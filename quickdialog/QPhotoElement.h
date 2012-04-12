//
//  QPhotoElement.h
//  TacosTaco
//
//  Created by Rodolfo Wilhelmy on 1/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "QLabelElement.h"

@interface QPhotoElement : QLabelElement

@property (nonatomic, strong) UIImage *photo;
@property (nonatomic) CGSize photoSize;
@property (nonatomic, strong) UIImageView *photoView;

- (QPhotoElement *)initWithTitle:(NSString *)title photo:(UIImage *)photo;
- (void)updatePhoto:(UIImage *)photo;

@end
