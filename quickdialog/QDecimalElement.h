//
//  Created by escoz on 8/8/11.
//
//  To change this template use File | Settings | File Templates.
//


#import <Foundation/Foundation.h>


@interface QDecimalElement : QEntryElement {

}


@property(nonatomic, assign) float floatValue;
@property(nonatomic, assign) NSUInteger fractionDigits;

- (QDecimalElement *)initWithTitle:(NSString *)string value:(float)value;
- (QDecimalElement *)initWithValue:(float)value;

@end