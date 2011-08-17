//
//  Created by escoz on 7/12/11.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@class QRootElement;


@interface QMapElement : QRootElement {

@protected
    CLLocationCoordinate2D _coordinate;
}

- (QMapElement *)initWithTitle:(NSString *)string coordinate:(CLLocationCoordinate2D)param;
@end