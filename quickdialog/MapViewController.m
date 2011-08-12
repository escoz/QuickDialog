//
//  Created by escoz on 7/12/11.
//
//  To change this template use File | Settings | File Templates.
//


#import <CoreLocation/CoreLocation.h>
#import <MapKit/MKAnnotation.h>
#import "MapViewController.h"
#import "QuickAnnotation.h"


@implementation MapViewController



- (MapViewController *)initWithTitle:(NSString *)title coordinate:(CLLocationCoordinate2D)coordinate {
    self = [self initWithCoordinate:coordinate];
    _mapTitle = title;
    return self;
}

- (MapViewController *)initWithCoordinate:(CLLocationCoordinate2D)coordinate {

    self = [super init];
    if (self != nil){
        _coordinate = coordinate;
        _mapView = [[MKMapView alloc] init];
        _mapView.delegate = self;

        self.view = _mapView;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    _mapView.region = MKCoordinateRegionMake(_coordinate, MKCoordinateSpanMake(0.05, 0.05));
    _mapView.zoomEnabled = YES;
    [_mapView regionThatFits:_mapView.region];

    QuickAnnotation *current = [[QuickAnnotation alloc] initWithCoordinate:_coordinate title:_mapTitle];
    [_mapView addAnnotation:current];

    self.title = _mapTitle;
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    MKPinAnnotationView *pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"reuse"];
    pin.animatesDrop = YES;
    pin.canShowCallout = NO;
    pin.pinColor = MKPinAnnotationColorGreen;
    return pin;
}

@end