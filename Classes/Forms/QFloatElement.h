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

#import "QuickDialogTableView.h"
#import "QLabelElement.h"

/**
  QFloatElement: shows an slider control.
*/

@interface QFloatElement : QLabelElement {
    
    float _floatValue;
    float _minimumValue;
    float _maximumValue;
}

@property(nonatomic, assign) float floatValue;
@property(nonatomic, assign) float minimumValue;
@property(nonatomic, assign) float maximumValue;

- (QFloatElement *)init;
- (QFloatElement *)initWithTitle:(NSString *)string value:(float)value;
- (QElement *)initWithValue:(float)value;
@end
