//
//  QTimerElement.h
//  QuickDialog
//
//  Created by Francis Visoiu Mistrih on 25/07/2014.
//
//

#import "QButtonElement.h"

extern double const kCriticalTime;
extern double const kRefreshTick;
extern double const kInitTimeInterval;

@interface QTimerElement : QRootElement

@property (strong, nonatomic) NSDate *startingDate;
@property (strong, nonatomic) NSDate *endingDate;
@property NSTimeInterval timeInterval;

- (QTimerElement *)initWithStartingDate:(NSDate *)startingDate andEndingDate:(NSDate *)endingDate;

@end
