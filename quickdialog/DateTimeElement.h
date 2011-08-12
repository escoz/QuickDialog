//
//  Created by escoz on 7/19/11.
//
//  To change this template use File | Settings | File Templates.
//


#import "RootElement.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class RootElement;


@interface DateTimeElement : RootElement {
    NSDate * _dateValue;
@private
    UIDatePickerMode _mode;
}

@property(nonatomic, retain) NSDate *dateValue;

@property (assign) UIDatePickerMode mode;

- (DateTimeElement *)initWithTitle:(NSString *)string date:(NSDate *)date;

@end