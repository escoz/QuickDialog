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

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#import "QRootElement.h"

/**
  QMapElement: when selected, shows a fullscreen map with the location selected. Requires a lat/long value.
*/

@interface QMapElement : QRootElement {

@protected
    CLLocationCoordinate2D _coordinate;
}

@property(nonatomic) CLLocationCoordinate2D coordinate;

- (QMapElement *)initWithTitle:(NSString *)string coordinate:(CLLocationCoordinate2D)param;

- (void)setLat:(double)lat;

- (void)setLng:(double)lng;


@end
