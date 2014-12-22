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


#import "QElement.h"

#import "QRootElement.h"

/**
  QTextElement: freeform text, which is rendered with the font provided.
*/

@interface QTextElement : QRootElement {

@protected
    NSString *_text;
    UIColor *_color;
}

@property(nonatomic, strong) NSString *text;
@property(nonatomic, retain) UIColor *color;

- (QTextElement *)initWithText:(NSString *)string;
@end
