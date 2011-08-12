//
//  Created by escoz on 7/15/11.
//
#import "RootElement.h"
#import "Element.h"
#import "LabelElement.h"
#import "EntryElement.h"
#import "DateTimeInlineElement.h"
#import "EntryTableViewCell.h"
#import "DateEntryTableViewCell.h"
#import "QuickDialogTableView.h"


@implementation DateTimeInlineElement


@synthesize dateValue = _dateValue;
@synthesize mode = _mode;
@synthesize centerLabel = _centerLabel;


- (DateTimeInlineElement *)initWithTitle:(NSString *)string date:(NSDate *)date {
    self = [super initWithTitle:string Value:[date description]];
    if (self!=nil){
        _dateValue = date;
        _mode = UIDatePickerModeDateAndTime;
    }
    return self;
}

- (DateTimeInlineElement *)initWithDate:(NSDate *)date {
    return [self initWithTitle:nil date:date];

}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {

    DateEntryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuickformDateTimeInlineElement"];
    if (cell==nil){
        cell = [[DateEntryTableViewCell alloc] init];
    }
    [cell prepareForElement:self inTableView:tableView];
    return cell;

}

- (void)fetchValueIntoObject:(id)obj {
	if (_key==nil)
		return;
    [obj setValue:_dateValue forKey:_key];
}


@end