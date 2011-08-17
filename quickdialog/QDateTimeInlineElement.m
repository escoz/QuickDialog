//
//  Created by escoz on 7/15/11.
//
#import "QRootElement.h"
#import "QElement.h"
#import "QLabelElement.h"
#import "QEntryElement.h"
#import "QDateTimeInlineElement.h"
#import "QEntryTableViewCell.h"
#import "QDateEntryTableViewCell.h"
#import "QuickDialogTableView.h"


@implementation QDateTimeInlineElement


@synthesize dateValue = _dateValue;
@synthesize mode = _mode;
@synthesize centerLabel = _centerLabel;


- (QDateTimeInlineElement *)initWithTitle:(NSString *)string date:(NSDate *)date {
    self = [super initWithTitle:string Value:[date description]];
    if (self!=nil){
        _dateValue = date;
        _mode = UIDatePickerModeDateAndTime;
    }
    return self;
}

- (QDateTimeInlineElement *)initWithDate:(NSDate *)date {
    return [self initWithTitle:nil date:date];

}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {

    QDateEntryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuickformDateTimeInlineElement"];
    if (cell==nil){
        cell = [[QDateEntryTableViewCell alloc] init];
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