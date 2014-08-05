//
//  QTimerElement.m
//  QuickDialog
//
//  Created by Francis Visoiu Mistrih on 25/07/2014.
//
//

#import "QTimerElement.h"

double const kCriticalTime = 50.0f;
double const kRefreshTick = 1.0;
double const kInitTimeInterval = 60.0;

@interface QTimerElement () {
    NSTimer *refreshTimer;
    UILabel *timerLabel;
}

@end

@implementation QTimerElement

- (QTimerElement *)init {
    self = [super init];
    if (self) {
        _timeInterval = kInitTimeInterval;
        self.appearance = [self.appearance copy];
        timerLabel = [[UILabel alloc] init];
        [self startTimerWithStartingDate:[NSDate date] andEndingDate:[[NSDate date] dateByAddingTimeInterval:_timeInterval]];
    }

    return self;
}

- (void)startTimerWithStartingDate:(NSDate *)startingDate andEndingDate:(NSDate *)endingDate {
    _startingDate = startingDate;
    _endingDate = endingDate;
    refreshTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshRemainingTimeLabel:) userInfo:nil repeats:YES];
    _timeInterval = [refreshTimer timeInterval];
}

- (void)refreshRemainingTimeLabel:(id)sender {
    _startingDate = [NSDate date];
    _timeInterval = [_endingDate timeIntervalSinceDate:_startingDate];
    [timerLabel setText:[QTimerElement stringFromTimeInterval:_timeInterval]];
    if (_timeInterval <= 0) {
        [refreshTimer invalidate];
    } else if (_timeInterval < kCriticalTime) {
        [self.appearance setBackgroundColorEnabled:[UIColor redColor]];
        [[(QuickDialogController *)self.controller quickDialogTableView] reloadCellForElements:self, nil];
    }
}

+ (NSString *)stringFromTimeInterval:(NSTimeInterval)interval {
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
    [cell.contentView addSubview:timerLabel];


    return cell;
}

@end
