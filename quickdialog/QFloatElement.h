//
//  Created by escoz on 7/11/11.
//
//  To change this template use File | Settings | File Templates.
//


#import <Foundation/Foundation.h>

@class QElement;
@class QLabelElement;


@interface QFloatElement : QLabelElement {

    float _floatValue;
}

@property(nonatomic, assign) float floatValue;


- (QFloatElement *)initWithTitle:(NSString *)string value:(float)value;
- (QElement *)initWithValue:(float)value;
@end