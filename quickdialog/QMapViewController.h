//
//  Created by escoz on 7/12/11.
//
//  To change this template use File | Settings | File Templates.
//


#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>


@interface QMapViewController : UIViewController <MKMapViewDelegate> {

@private
    CLLocationCoordinate2D _coordinate;
    MKMapView * _mapView;
    NSString *_mapTitle;
}

- (QMapViewController *)initWithCoordinate:(CLLocationCoordinate2D)d;

- (QMapViewController *)initWithTitle:(NSString *)string coordinate:(CLLocationCoordinate2D)d;
@end