//
//  Created by escoz on 8/8/11.
//
//  To change this template use File | Settings | File Templates.
//


#import <Foundation/Foundation.h>


@interface DecimalElement : EntryElement {

}


@property(nonatomic, assign) float floatValue;
@property(nonatomic, assign) NSUInteger fractionDigits;

- (DecimalElement *)initWithTitle:(NSString *)string value:(float)value;
- (DecimalElement *)initWithValue:(float)value;

@end