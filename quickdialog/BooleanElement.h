//
//  Created by escoz on 7/8/11.
//
//  To change this template use File | Settings | File Templates.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Element;
@class LabelElement;

@interface BooleanElement : LabelElement  {
    BOOL _boolValue;
    BOOL _enabled;
@private
    UIImage *_onImage;
    UIImage *_offImage;
}

@property(nonatomic, retain) UIImage *onImage;
@property(nonatomic, retain) UIImage *offImage;
@property (nonatomic) BOOL boolValue;
@property(nonatomic) BOOL enabled;

- (BooleanElement *)initWithTitle:(NSString *)title BoolValue:(BOOL)value;

- (void)switched:(id)switched;
@end