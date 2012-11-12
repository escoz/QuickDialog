//                                
// Copyright 2011 ESCOZ Inc  - http://escoz.com
// 
// Licensed under the Apache License, Version 2.0 (the "License"); you may not use this 
// file except in compliance with the License. You may obtain a copy of the License at 
// 
// http://www.apache.org/licenses/LICENSE-2.0 
// 
// Unless required by applicable law or agreed to in writing, software distributed under
// the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF 
// ANY KIND, either express or implied. See the License for the specific language governing
// permissions and limitations under the License.
//

#import <MapKit/MKAnnotation.h>
#import "QMapViewController.h"
#import "QMapAnnotation.h"

@implementation QMapViewController


- (QMapViewController *)initWithTitle:(NSString *)title coordinate:(CLLocationCoordinate2D)coordinate {
    self = [self initWithCoordinate:coordinate];
    _mapTitle = title;
    return self;
}

- (QMapViewController *)initWithCoordinate:(CLLocationCoordinate2D)coordinate {

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

    QMapAnnotation *current = [[QMapAnnotation alloc] initWithCoordinate:_coordinate title:_mapTitle];
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
