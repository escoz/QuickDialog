//
//  Created by escoz on 7/12/11.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@class RootElement;


@interface MapElement : RootElement {

@protected
    CLLocationCoordinate2D _coordinate;
}

- (MapElement *)initWithTitle:(NSString *)string coordinate:(CLLocationCoordinate2D)param;
@end