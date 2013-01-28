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


#import "QRootElement.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface QDateTimeElement : QRootElement {
    NSDate * _dateValue;
@private
    UIDatePickerMode _mode;
    NSInteger _minuteInterval;
}

@property(nonatomic, retain) NSDate *dateValue;
@property(nonatomic, assign) NSNumber *ticksValue;

@property (assign) NSInteger minuteInterval;

@property (assign) UIDatePickerMode mode;

- (QDateTimeElement *)init;

- (QDateTimeElement *)initWithTitle:(NSString *)string date:(NSDate *)date;

@end