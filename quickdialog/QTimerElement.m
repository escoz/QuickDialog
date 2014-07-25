//
//  QTimerElement.m
//  QuickDialog
//
//  Created by Francis Visoiu Mistrih on 25/07/2014.
//
//

#import "QTimerElement.h"

@interface QTimerElement () {
    NSTimer *refreshTimer;
    UILabel *timerLabel;
    BOOL isAdded;
}

@end

@implementation QTimerElement

- (QTimerElement *)init {
    self = [super init];
    if (self) {
        isAdded = NO;
    }

    return self;
}

- (QTimerElement *)initWithStartingDate:(NSDate *)startingDate andEndingDate:(NSDate *)endingDate {
    self = [self init];
    if (self) {
        timerLabel = [[UILabel alloc] init];
        _startingDate = startingDate;
        _endingDate = endingDate;
        refreshTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshRemainingTimeLabel:) userInfo:nil repeats:YES];
        _timeInterval = [refreshTimer timeInterval];

        [refreshTimer fire];
    }

    return self;
}

- (void)refreshRemainingTimeLabel:(id)sender {
    _startingDate = [NSDate date];
    _timeInterval = [_endingDate timeIntervalSinceDate:_startingDate];
    [timerLabel setText:[self stringFromTimeInterval:_timeInterval]];
    if (_timeInterval <= 0) {
        [refreshTimer invalidate];
    }
}

- (NSString *)stringFromTimeInterval:(NSTimeInterval)interval {
    NSInteger ti = (NSInteger)interval;
    NSInteger seconds = ti % 60;
    NSInteger minutes = (ti / 60) % 60;
    NSInteger hours = (ti / 3600);
    return [NSString stringWithFormat:@"%02ld:%02ld:%02ld", (long)hours, (long)minutes, (long)seconds];
}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {
    UITableViewCell *cell = [super getCellForTableView:tableView controller:controller];

    timerLabel.frame = CGRectMake(0,0, cell.contentView.frame.size.width, cell.contentView.frame.size.height);
    timerLabel.textAlignment = NSTextAlignmentCenter;
    if (!isAdded) {
        isAdded = YES;
        [cell.contentView addSubview:timerLabel];
    }


    return cell;
}

@end
