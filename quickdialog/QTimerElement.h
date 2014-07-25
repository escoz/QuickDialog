//
//  QTimerElement.h
//  QuickDialog
//
//  Created by Francis Visoiu Mistrih on 25/07/2014.
//
//

#import "QButtonElement.h"

@interface QTimerElement : QRootElement

@property (strong, nonatomic) NSDate *startingDate;
@property (strong, nonatomic) NSDate *endingDate;
@property NSTimeInterval timeInterval;

- (QTimerElement *)initWithStartingDate:(NSDate *)startingDate andEndingDate:(NSDate *)endingDate;

@end
