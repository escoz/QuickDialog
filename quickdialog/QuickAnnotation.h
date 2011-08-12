//
//  Created by escoz on 7/12/11.
//
//  To change this template use File | Settings | File Templates.
//


#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface QuickAnnotation : NSObject<MKAnnotation> {

@private
    CLLocationCoordinate2D _coordinate;
    NSString *_title;
    NSString *_subtitle;
}

- (QuickAnnotation *)initWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title;

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@end