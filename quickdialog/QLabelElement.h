//
//  Created by escoz on 7/7/11.
//
//  To change this template use File | Settings | File Templates.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class QElement;
@class QRootElement;

@interface QLabelElement : QRootElement {

@protected
    NSString *_value;
    UIImage *_image;
}

@property(nonatomic, strong) UIImage *image;
@property(nonatomic, strong) NSString *value;


- (QLabelElement *)initWithTitle:(NSString *)string Value:(NSString *)value;
@end