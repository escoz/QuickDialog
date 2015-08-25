//                                
// Copyright 2011 ESCOZ Inc  - http://escoz.com
// 
// Licensed under the Apache License, Version 2.0 (the "License"); you may not use this 
// file except in compliance with the License. You may obtain a copy of the License at 
// 
// http://www.apache.org/licenses/LICENSE-2.0 
// 
// Unless required by applicable law or agreed to in writing, software distributed under
// the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF 
// ANY KIND, either express or implied. See the License for the specific language governing
// permissions and limitations under the License.
//

#import "QAppearance.h"
#import "QElement.h"
#import "QElement+Appearance.h"
#import "QDateInlineTableViewCell.h"

@interface QDateInlineTableViewCell ()
@property(nonatomic, strong) UIDatePicker *pickerView;
@property(nonatomic, weak) QDateTimeInlineElement *element;
@property(nonatomic) BOOL presentingPicker;
@end

@implementation QDateInlineTableViewCell
{
}


- (QDateInlineTableViewCell *)init {
    self = [self initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"QuickformDateTimeInlineElement"];
    if (self!=nil){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)prepareDateTimePicker:(QDateTimeInlineElement *)element
{
    if (!self.pickerView)
        self.pickerView = [[UIDatePicker alloc] init];

    self.pickerView.timeZone = [NSTimeZone localTimeZone];
    [self.pickerView sizeToFit];
    self.pickerView.datePickerMode = element.mode;
    self.pickerView.maximumDate = element.maximumDate;
    self.pickerView.minimumDate = element.minimumDate;
    self.pickerView.minuteInterval = element.minuteInterval;

    if (element.mode != UIDatePickerModeCountDownTimer && element.dateValue != nil)
        self.pickerView.date = element.dateValue;
    else if (element.mode == UIDatePickerModeCountDownTimer && element.ticksValue != nil)
        self.pickerView.countDownDuration = [element.ticksValue doubleValue];
}

- (void) dateChanged:(id)sender{
    if (self.element.mode == UIDatePickerModeCountDownTimer){
        self.element.ticksValue = [NSNumber numberWithDouble:self.pickerView.countDownDuration];
    } else {
        self.element.dateValue = self.pickerView.date;
    }
    if (self.element.onValueChanged!=nil)
        self.element.onValueChanged(self.element);
    [self prepareForElement:self.element inTableView:nil];
}

- (void)prepareForElement:(QDateTimeInlineElement *)element inTableView:(QuickDialogTableView *)tableView {

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

    self.element = element;
    if (element.customDateFormat!=nil){
        dateFormatter.dateFormat = element.customDateFormat;
    } else {
        switch (element.mode) {
            case UIDatePickerModeDate:
                [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
                [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
                break;
            case UIDatePickerModeTime:
                [dateFormatter setDateStyle:NSDateFormatterNoStyle];
                [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
                break;
            case UIDatePickerModeDateAndTime:
                [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
                [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
                break;
            case UIDatePickerModeCountDownTimer:
                break;
        }
    }

    [self prepareDateTimePicker:element];

    NSString *value = element.mode!=UIDatePickerModeCountDownTimer
            ? [dateFormatter stringFromDate:element.dateValue]
            : [self formatInterval:element.ticksValue.doubleValue];

    self.textLabel.text = element.title;
    self.detailTextLabel.text = value;
    [self applyAppearanceForElement:element];;

}

- (void)applyAppearanceForElement:(QElement *)element
{
    [super applyAppearanceForElement:element];

    self.detailTextLabel.textColor = element.enabled ? element.appearance.entryTextColorEnabled : element.appearance.entryTextColorDisabled;
}


- (BOOL)isEditing
{
    return self.presentingPicker;
}

- (void)setEditing:(BOOL)editing
{
    if (self.presentingPicker == editing)
        return;

    self.presentingPicker = editing;

    if (editing){
        [self.contentView addSubview:self.pickerView];
        self.pickerView.alpha = 0.0;
    }

    [UIView animateWithDuration:0.3 animations:^{
        self.pickerView.alpha = editing ? 1.0 : 0.0;

    } completion:^(BOOL finished){
        if (editing)  {
            [self.pickerView addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
        } else {
            [self.pickerView removeTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
            [self.pickerView removeFromSuperview];
        }

    }];
}

- (BOOL)endEditing:(BOOL)force
{
    [self setEditing:NO];
    return YES;
}


- (NSString *) formatInterval: (NSTimeInterval) interval
{
    unsigned long seconds = (unsigned long) interval;
    unsigned long minutes = seconds / 60;
    unsigned long hours = minutes / 60;
    minutes %= 60;

    NSMutableString * result = [NSMutableString new];
    if(hours)
        [result appendFormat:@"%d hrs, ", (int) hours];

    [result appendFormat:@"%d mins", (int) minutes];
    //[result appendFormat:@"%d", (int) seconds];

    return result;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [super layoutSubviewsInsideBounds:CGRectMake(0, 0, self.contentView.frame.size.width, 44)];
    [self.pickerView sizeToFit];
    CGFloat width = self.pickerView.frame.size.width;
    self.pickerView.frame = CGRectMake((self.contentView.frame.size.width-width) / 2, 44, width, self.pickerView.frame.size.height);
}


@end
