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

#import "QEntryTableViewCell.h"
#import "QDateEntryTableViewCell.h"
#import "QDateTimeInlineElement.h"
#import "QTextField.h"

UIDatePicker *QDATEENTRY_GLOBAL_PICKER;

@implementation QDateEntryTableViewCell

@synthesize pickerView = _pickerView;
@synthesize centeredLabel = _centeredLabel;


- (QDateEntryTableViewCell *)init {
    self = [self initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"QuickformDateTimeInlineElement"];
    if (self!=nil){
        [self createSubviews];
		self.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
    return self;
}

+ (UIDatePicker *)getPickerForDate {
    QDATEENTRY_GLOBAL_PICKER = [[UIDatePicker alloc] init];
    return QDATEENTRY_GLOBAL_PICKER;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [super textFieldDidEndEditing:textField];
    self.selected = NO;
    [_pickerView removeTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    _pickerView = nil;

}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    QDateTimeInlineElement *const element = ((QDateTimeInlineElement *) _entryElement);

    _pickerView = [QDateEntryTableViewCell getPickerForDate];
    [_pickerView sizeToFit];
    _textField.inputView = _pickerView;
    [_pickerView addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    _pickerView.datePickerMode = element.mode;
    _pickerView.maximumDate = element.maximumDate;
    _pickerView.minimumDate = element.minimumDate;
    _pickerView.minuteInterval = element.minuteInterval;
    
    if (element.dateValue!=nil)
        _pickerView.date = element.dateValue;

    [super textFieldDidBeginEditing:textField];
    self.selected = YES;
}

- (void)createSubviews {
    [super createSubviews];
    _textField.hidden = YES;

    self.centeredLabel = [[UILabel alloc] init];
    self.centeredLabel.textColor = [UIColor colorWithRed:0.243 green:0.306 blue:0.435 alpha:1.0];
    self.centeredLabel.highlightedTextColor = [UIColor whiteColor];
    self.centeredLabel.font = [UIFont systemFontOfSize:17];
    self.centeredLabel.textAlignment = NSTextAlignmentCenter;
	self.centeredLabel.backgroundColor = [UIColor clearColor];
    self.centeredLabel.frame = CGRectMake(10, 10, self.contentView.frame.size.width-20, self.contentView.frame.size.height-20);
    [self.contentView addSubview:self.centeredLabel];
}

- (void) dateChanged:(id)sender{
    QDateTimeInlineElement *const element = ((QDateTimeInlineElement *) _entryElement);
    if (element.mode == UIDatePickerModeCountDownTimer){
        element.ticksValue = [NSNumber numberWithDouble:_pickerView.countDownDuration];
    } else {
        element.dateValue = _pickerView.date;
    }
    [self prepareForElement:_entryElement inTableView:_quickformTableView];
    if (element.onValueChanged!=nil)
        element.onValueChanged(_entryElement);

}

- (void)prepareForElement:(QEntryElement *)element inTableView:(QuickDialogTableView *)tableView {
    [super prepareForElement:element inTableView:tableView];

    QDateTimeInlineElement *dateElement = ((QDateTimeInlineElement *) element);

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

    if (element.customDateFormat!=nil){
        dateFormatter.dateFormat = element.customDateFormat;
    } else {
        switch (dateElement.mode) {
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

    NSString *value = dateElement.mode!=UIDatePickerModeCountDownTimer
            ? [dateFormatter stringFromDate:dateElement.dateValue]
            : [self formatInterval:dateElement.ticksValue.doubleValue];
    if (!dateElement.centerLabel){
		self.textLabel.text = element.title;
        self.centeredLabel.text = nil;
		self.detailTextLabel.text = value;
		
    } else {
        self.textLabel.text = nil;
		self.centeredLabel.text = value;
    }

	_textField.text = value;
    _textField.placeholder = dateElement.placeholder;

    _textField.inputAccessoryView.hidden = dateElement.hiddenToolbar;
}

- (NSString *) formatInterval: (NSTimeInterval) interval
{
    unsigned long seconds = (unsigned long) interval;
    unsigned long minutes = seconds / 60;
    seconds %= 60;
    unsigned long hours = minutes / 60;
    minutes %= 60;

    NSMutableString * result = [NSMutableString new];
    if(hours)
     [result appendFormat:@"%d hrs, ", (int) hours];

    [result appendFormat:@"%d mins", (int) minutes];
    //[result appendFormat:@"%d", (int) seconds];

    return result;
}

@end
