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

#import "QDateEntryTableViewCell.h"
#import "QDateTimeInlineElement.h"

@implementation QDateEntryTableViewCell

- (instancetype)init {
    self = [self initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"QuickformDateTimeInlineElement"];
    if (self!=nil){
        [self createSubviews];
		self.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
    return self;
}

- (QDateTimeInlineElement *)currentDateTimeElement
{
    return (QDateTimeInlineElement *)self.currentEntryElement;
}


- (void)textFieldDidEndEditing:(UITextField *)textField {
    [super textFieldDidEndEditing:textField];
    self.selected = NO;
    [self.pickerView removeTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    self.pickerView = nil;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {

    [self prepareDateTimePicker:self.currentDateTimeElement];

    self.textField.inputView = self.pickerView;
    [super textFieldDidBeginEditing:textField];
    self.selected = YES;
}

- (void)prepareDateTimePicker:(QDateTimeInlineElement * const)element
{
    if (!self.pickerView)
        self.pickerView = [[UIDatePicker alloc] init];

    self.pickerView.timeZone = [NSTimeZone localTimeZone];
    [self.pickerView sizeToFit];
    [self.pickerView addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    self.pickerView.datePickerMode = element.mode;
    self.pickerView.maximumDate = element.maximumDate;
    self.pickerView.minimumDate = element.minimumDate;
    self.pickerView.minuteInterval = element.minuteInterval;

    if (element.mode != UIDatePickerModeCountDownTimer && element.dateValue != nil)
        self.pickerView.date = element.dateValue;
    else if (element.mode == UIDatePickerModeCountDownTimer && element.ticksValue != nil)
        self.pickerView.countDownDuration = [element.ticksValue doubleValue];
}

- (void)createSubviews {
    [super createSubviews];
    self.textField.hidden = YES;
    self.textField.userInteractionEnabled = NO;

    self.centeredLabel = [[UILabel alloc] init];
    self.centeredLabel.highlightedTextColor = [UIColor whiteColor];
    self.centeredLabel.font = [UIFont systemFontOfSize:17];
    self.centeredLabel.textAlignment = NSTextAlignmentCenter;
	self.centeredLabel.backgroundColor = [UIColor clearColor];
    self.centeredLabel.frame = CGRectMake(10, 10, self.contentView.frame.size.width-20, self.contentView.frame.size.height-20);
    [self.contentView addSubview:self.centeredLabel];
}

- (void) dateChanged:(id)sender{
    QDateTimeInlineElement *element = self.currentDateTimeElement;
    if (element.mode == UIDatePickerModeCountDownTimer){
        element.ticksValue = @(self.pickerView.countDownDuration);
    } else {
        element.dateValue = self.pickerView.date;
    }
    [self prepareForElement:self.currentDateTimeElement];
    
    [element handleEditingChanged:self];
}

- (void)prepareForElement:(QEntryElement *)element
{
    [super prepareForElement:element];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

    if (element.customDateFormat!=nil){
        dateFormatter.dateFormat = element.customDateFormat;
    } else {
        switch (self.currentDateTimeElement.mode) {
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

    NSString *value = self.currentDateTimeElement.mode!=UIDatePickerModeCountDownTimer
            ? [dateFormatter stringFromDate:self.currentDateTimeElement.dateValue]
            : [self formatInterval:self.currentDateTimeElement.ticksValue.doubleValue];
    if (!self.currentDateTimeElement.centerLabel){
		self.textLabel.text = element.title;
        self.centeredLabel.text = nil;
		self.detailTextLabel.text = value;
		
    } else {
        self.textLabel.text = nil;
		self.centeredLabel.text = value;
    }

	self.textField.text = value;
    self.textField.placeholder = self.currentDateTimeElement.placeholder;

    self.textField.inputAccessoryView.hidden = self.currentDateTimeElement.hiddenToolbar;

    self.centeredLabel.textColor = self.currentDateTimeElement.appearance.entryTextColorEnabled;
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

@end
