//
//  Created by escoz on 7/15/11.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class TextElement;
@class EntryElement;


@interface DateTimeInlineElement : EntryElement {
    NSDate * _dateValue;
@private
    UIDatePickerMode _mode;
    BOOL _centerLabel;
}

@property(nonatomic, retain) NSDate *dateValue;

@property (assign) UIDatePickerMode mode;

@property(nonatomic) BOOL centerLabel;

- (DateTimeInlineElement *)initWithDate:(NSDate *)date;

- (DateTimeInlineElement *)initWithTitle:(NSString *)string date:(NSDate *)date;


@end