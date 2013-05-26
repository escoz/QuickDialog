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

// TODO: Needs to be rewritten to use a custom UIViewController with the elements in it.
// the animation is not smooth when using the dateselector as a keyboard


#import "QDateTimeElement.h"
#import "QDateTimeInlineElement.h"
#import "QuickDialogController.h"
#import "QuickDialog.h"


@interface QDateTimeElement ()
- (void)initializeRoot;
- (void)updateElements;

@end

@implementation QDateTimeElement


@synthesize dateValue = _dateValue;

- (void)setMode:(UIDatePickerMode)mode {
	_mode = mode;
	[[self sections] removeAllObjects];
	[self initializeRoot];
}

- (void)setMinuteInterval:(NSInteger)minuteInterval
{
    _minuteInterval = minuteInterval;
    self.sections = nil;
    [self initializeRoot];
}

- (void)setDateValue:(NSDate *)date {
    _dateValue = date;
    [self updateElements];
}

- (void)setTicksValue:(NSNumber *)ticks {
    if (ticks!=nil)
        [self setDateValue:[NSDate dateWithTimeIntervalSince1970:ticks.doubleValue]];
}

-(NSNumber *)ticksValue {
    return [NSNumber numberWithDouble:[self.dateValue timeIntervalSince1970]];
}

- (UIDatePickerMode)mode {
    return _mode;
}

- (NSInteger)minuteInterval
{
    return _minuteInterval;
}

- (QDateTimeElement *)init {
    self = [super init];
    _grouped = YES;
    _mode = UIDatePickerModeDateAndTime;
    [self initializeRoot];
    return self;
}

- (QDateTimeElement *)initWithTitle:(NSString *)title date:(NSDate *)date {
    self = [super init];
    if (self!=nil){
        _grouped = YES;
        _mode = UIDatePickerModeDateAndTime;
		_title = title;
        _dateValue = date;
        [self updateElements];
    }
    return self;
}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {
    UITableViewCell *cell = [super getCellForTableView:tableView controller:controller];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    switch (_mode) {
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

    cell.detailTextLabel.text = [dateFormatter stringFromDate:_dateValue];

    return cell;
}


- (void)initializeRoot {
    NSDate *dateForSection = _dateValue;
    if (dateForSection==nil){
        dateForSection = NSDate.date;
    }
	QSection *section = [[QSection alloc] initWithTitle:(_mode == UIDatePickerModeDateAndTime ? @"\n" : @"\n\n")];
    if (_mode == UIDatePickerModeTime || _mode == UIDatePickerModeDateAndTime){
        QDateTimeInlineElement *timeElement = (QDateTimeInlineElement *) [[QDateTimeInlineElement alloc] initWithKey:@"time"];
        timeElement.dateValue = dateForSection;
        timeElement.centerLabel = YES;
        timeElement.mode = UIDatePickerModeTime;
        timeElement.hiddenToolbar = YES;
        timeElement.minuteInterval = _minuteInterval;
        
        [section addElement:timeElement];
    }
    [self addSection:section];
}

- (void)updateElements
{
    QDateTimeInlineElement *dateElement = (QDateTimeInlineElement *)[self elementWithKey:@"date"];
    QDateTimeInlineElement *timeElement = (QDateTimeInlineElement *)[self elementWithKey:@"time"];
    
    NSDate *dateForElements = (_dateValue == nil) ? NSDate.date : _dateValue;
    
    if (dateElement != nil) {
        dateElement.dateValue = dateForElements;
    }
    
    if (timeElement != nil) {
        timeElement.dateValue = dateForElements;
    }
}

- (void)fetchValueIntoObject:(id)obj {
	if (_key==nil)
		return;
    [obj setValue:_dateValue forKey:_key];
}

- (void)selected:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller indexPath:(NSIndexPath *)indexPath {

    if (self.sections==nil)
            return;

    QuickDialogController * newController = [controller controllerForRoot:self];
    newController.quickDialogTableView.scrollEnabled = NO;
    [controller displayViewController:newController];

	__weak QuickDialogController *controllerForBlock = newController;
	
    newController.willDisappearCallback = ^{
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

        [((QSection *)[controllerForBlock.root.sections objectAtIndex:0]) fetchValueIntoObject:dict];

        NSDate *date;
        NSDate *time;
        if (_mode == UIDatePickerModeTime){
            time = [dict valueForKey:@"time"];
            date = [NSDate date];
        }
        else if (_mode == UIDatePickerModeDate){
            date = [dict valueForKey:@"date"];
            time = [NSDate date];
        }
        else if (_mode == UIDatePickerModeDateAndTime){
            date = [dict valueForKey:@"date"];
            time = [dict valueForKey:@"time"];
        } else {
            NSLog(@"This control was not created to handle this time of UIDatePickerMode");
        }

        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:date];
        NSDateComponents *timeComponents = [[NSCalendar currentCalendar] components:kCFCalendarUnitHour | kCFCalendarUnitMinute | kCFCalendarUnitSecond fromDate:time];

        [components setHour:[timeComponents hour]];
        [components setMinute:[timeComponents minute]];
        [components setSecond:[timeComponents second]];
        self.dateValue = [[NSCalendar currentCalendar] dateFromComponents:components];
    };

    [newController.quickDialogTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];

}


@end
