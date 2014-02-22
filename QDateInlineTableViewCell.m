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
#import "QDateInlineTableViewCell.h"

@implementation QDateInlineTableViewCell
{
    UIDatePicker *_pickerView;
    BOOL _presentingPicker;
    __weak QDateTimeInlineElement *_element;
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
    if (!_pickerView)
        _pickerView = [[UIDatePicker alloc] init];

    _pickerView.timeZone = [NSTimeZone localTimeZone];
    [_pickerView sizeToFit];
    _pickerView.datePickerMode = element.mode;
    _pickerView.maximumDate = element.maximumDate;
    _pickerView.minimumDate = element.minimumDate;
    _pickerView.minuteInterval = element.minuteInterval;

    if (element.mode != UIDatePickerModeCountDownTimer && element.dateValue != nil)
        _pickerView.date = element.dateValue;
    else if (element.mode == UIDatePickerModeCountDownTimer && element.ticksValue != nil)
        _pickerView.countDownDuration = [element.ticksValue doubleValue];
}

- (void) dateChanged:(id)sender{
    if (_element.mode == UIDatePickerModeCountDownTimer){
        _element.ticksValue = [NSNumber numberWithDouble:_pickerView.countDownDuration];
    } else {
        _element.dateValue = _pickerView.date;
    }
    if (_element.onValueChanged!=nil)
        _element.onValueChanged(_element);
    [self prepareForElement:_element inTableView:nil];
}

- (void)prepareForElement:(QDateTimeInlineElement *)element inTableView:(QuickDialogTableView *)tableView {

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

    _element = element;
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
    return _presentingPicker;
}

- (void)setEditing:(BOOL)editing
{
    if (_presentingPicker == editing)
        return;

    _presentingPicker = editing;

    if (editing){
        [self.contentView addSubview:_pickerView];
        _pickerView.alpha = 0.0;
    }

    [UIView animateWithDuration:0.3 animations:^{
        _pickerView.alpha = editing ? 1.0 : 0.0;

    } completion:^(BOOL finished){
        if (editing)  {
            [_pickerView addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
        } else {
            [_pickerView removeTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
            [_pickerView removeFromSuperview];
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
    [_pickerView sizeToFit];
    CGFloat width = _pickerView.frame.size.width;
    _pickerView.frame = CGRectMake((self.contentView.frame.size.width-width) / 2, 44, width, _pickerView.frame.size.height);
}


@end
