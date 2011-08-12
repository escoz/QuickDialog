//
//  Created by escoz on 7/12/11.
//
//  To change this template use File | Settings | File Templates.
//


#import <CoreLocation/CoreLocation.h>
#import "RootElement.h"
#import "MapElement.h"
#import "MapViewController.h"
#import "QuickDialogController.h"


@implementation MapElement

- (MapElement *)initWithTitle:(NSString *)title coordinate:(CLLocationCoordinate2D)coordinate {
    self = [super init];
    _title = title;
    _coordinate = coordinate;

    return self;
}

- (void)selected:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller indexPath:(NSIndexPath *)path {
    MapViewController *mapController = [[MapViewController alloc] initWithTitle:_title coordinate:_coordinate];
    [controller displayViewController:mapController];

}
@end