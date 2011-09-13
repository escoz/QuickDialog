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

@interface QTextElement : QElement {

@protected
    NSString *_text;
    UIFont *_font;
    UIColor *_color;
}

@property(nonatomic, strong) NSString *text;
@property(nonatomic, strong) UIFont *font;


@property(nonatomic, retain) UIColor *color;

- (QTextElement *)initWithText:(NSString *)string;
@end