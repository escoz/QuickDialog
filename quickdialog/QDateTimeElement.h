//
//  Created by escoz on 7/19/11.
//
//  To change this template use File | Settings | File Templates.
//


#import "QRootElement.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class QRootElement;


@interface QDateTimeElement : QRootElement {
    NSDate * _dateValue;
@private
    UIDatePickerMode _mode;
}

@property(nonatomic, retain) NSDate *dateValue;

@property (assign) UIDatePickerMode mode;

- (QDateTimeElement *)initWithTitle:(NSString *)string date:(NSDate *)date;

@end