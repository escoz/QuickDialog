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
#import "QEntryElement.h"

/**
  QDecimalElement: very much like an entry field, but allows only numbers to be typed. Automatically limits numbers to a predefined number of decimal places.
*/

@interface QDecimalElement : QEntryElement {

}

@property(nonatomic, retain) NSNumber * numberValue;
@property(nonatomic, assign) NSUInteger fractionDigits;

- (QDecimalElement *)initWithTitle:(NSString *)string value:(NSNumber *)value;
- (QDecimalElement *)initWithValue:(NSNumber *)value;

@end
