//
//  Created by escoz on 7/12/11.
//
//  To change this template use File | Settings | File Templates.
//


#import "QuickAnnotation.h"


@implementation QuickAnnotation

@synthesize coordinate = _coordinate;
@synthesize title = _title;
@synthesize subtitle = _subtitle;

- (QuickAnnotation *)initWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title {
    self = [super init];
    self.coordinate = coordinate;
    _title = title;

    return self;
}
@end