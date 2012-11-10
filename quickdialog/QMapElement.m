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

#ifdef MK_EXTERN

#import "QMapViewController.h"
#import "QMapElement.h"

@implementation QMapElement

@synthesize coordinate = _coordinate;

- (QMapElement *)init {
    self = [self initWithTitle:@"" coordinate:CLLocationCoordinate2DMake(0, 0)];
    return self;
}

- (QMapElement *)initWithTitle:(NSString *)title coordinate:(CLLocationCoordinate2D)coordinate {
    self = [super init];
    _title = title;
    _coordinate = coordinate;
    return self;
}

- (void)setLat:(double) lat {
    _coordinate.latitude = lat;
}

- (void)setLng:(double) lng {
    _coordinate.longitude = lng;
}

- (void)selected:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller indexPath:(NSIndexPath *)path {
    QMapViewController *mapController = [[QMapViewController alloc] initWithTitle:_title coordinate:_coordinate];
    [controller displayViewController:mapController];

}
@end

#endif
