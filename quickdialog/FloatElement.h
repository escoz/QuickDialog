//
//  Created by escoz on 7/11/11.
//
//  To change this template use File | Settings | File Templates.
//


#import <Foundation/Foundation.h>

@class Element;
@class LabelElement;


@interface FloatElement : LabelElement {

    float _floatValue;
}

@property(nonatomic, assign) float floatValue;


- (FloatElement *)initWithTitle:(NSString *)string value:(float)value;
- (Element *)initWithValue:(float)value;
@end