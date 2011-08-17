//
//  Created by escoz on 7/15/11.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class QTextElement;
@class QEntryElement;


@interface QDateTimeInlineElement : QEntryElement {
    NSDate * _dateValue;
@private
    UIDatePickerMode _mode;
    BOOL _centerLabel;
}

@property(nonatomic, retain) NSDate *dateValue;

@property (assign) UIDatePickerMode mode;

@property(nonatomic) BOOL centerLabel;

- (QDateTimeInlineElement *)initWithDate:(NSDate *)date;

- (QDateTimeInlineElement *)initWithTitle:(NSString *)string date:(NSDate *)date;


@end