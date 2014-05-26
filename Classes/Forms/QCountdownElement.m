#import "QCountdownElement.h"


@implementation QCountdownElement {

    NSNumber *_ticks;
}

- (QEntryElement *)init {
    self = [super init];
    if (self) {
        self.ticksValue = [NSNumber numberWithDouble:0];
    }

    return self;
}

- (void)setTicksValue:(NSNumber *)ticksValue {
    _ticks = ticksValue;
}

- (NSNumber *)ticksValue {
    return _ticks;
}


- (NSDate *)dateValue {
    return [NSDate dateWithTimeIntervalSinceNow:self.ticksValue.doubleValue];
}

- (void)setDateValue:(NSDate *)dateValue {
    NSLog(@"Don't set the date on the QCountdownElement");
}


- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {
    self.mode = UIDatePickerModeCountDownTimer;
    QDateEntryTableViewCell *cell = (QDateEntryTableViewCell *) [super getCellForTableView:tableView controller:controller];

    return cell;
}


@end
