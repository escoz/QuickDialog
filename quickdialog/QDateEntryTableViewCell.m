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

@implementation QDateEntryTableViewCell

@synthesize pickerView = _pickerView;
@synthesize centeredLabel = _centeredLabel;


- (QDateEntryTableViewCell *)init {
    self = [self initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"QuickformDateTimeInlineElement"];
    if (self!=nil){
        [self createSubviews];
		self.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    return self;
}

- (void)createSubviews {
    [super createSubviews];
    _textField.hidden = YES;

    _pickerView = [[UIDatePicker alloc] init];
    [_pickerView sizeToFit];
    _pickerView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    [_pickerView addTarget:self action:@selector(dateChanged:)
              forControlEvents:UIControlEventValueChanged];

    _textField.inputView = _pickerView;

    self.centeredLabel = [[UILabel alloc] init];
    self.centeredLabel.textColor = [UIColor colorWithRed:0.243 green:0.306 blue:0.435 alpha:1.0];
    self.centeredLabel.highlightedTextColor = [UIColor whiteColor];
    self.centeredLabel.font = [UIFont systemFontOfSize:17];
    self.centeredLabel.textAlignment = UITextAlignmentCenter;
	self.centeredLabel.backgroundColor = [UIColor clearColor];
    self.centeredLabel.frame = CGRectMake(10, 10, self.contentView.frame.size.width-20, self.contentView.frame.size.height-20);
    [self.contentView addSubview:self.centeredLabel];
}

- (void) dateChanged:(id)sender{
    ((QDateTimeInlineElement *)  _entryElement).dateValue = _pickerView.date;
    [self prepareForElement:_entryElement inTableView:_quickformTableView];
}

- (void)prepareForElement:(QEntryElement *)element inTableView:(QuickDialogTableView *)tableView {
    QDateTimeInlineElement *entry = (QDateTimeInlineElement *)element;
    [super prepareForElement:element inTableView:tableView];

    QDateTimeInlineElement *dateElement = ((QDateTimeInlineElement *) element);

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
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
            [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
            [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
			break;
    }
	
    if (!entry.centerLabel){
		self.textLabel.text = element.title;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.centeredLabel.text = nil;
		self.detailTextLabel.text = [dateFormatter stringFromDate:dateElement.dateValue];
		
    } else {
        self.selectionStyle = UITableViewCellSelectionStyleBlue;
        self.textLabel.text = nil;
		self.centeredLabel.text = [dateFormatter stringFromDate:dateElement.dateValue];
    }
	
	_textField.text = [dateFormatter stringFromDate:dateElement.dateValue];
    _pickerView.datePickerMode = dateElement.mode;
    _textField.placeholder = dateElement.placeholder;

    _textField.inputAccessoryView.hidden = entry.hiddenToolbar;
}


@end