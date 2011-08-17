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

@class QLabelElement;


@interface QEntryElement : QLabelElement {

@private
    NSString *_placeholder;
    NSString *_textValue;

    BOOL _hiddenToolbar;
    BOOL _isPassword;
}


@property(nonatomic, strong) NSString *textValue;
@property(nonatomic, strong) NSString *placeholder;
@property(assign) BOOL hiddenToolbar;
@property(assign) BOOL isPassword;

- (QEntryElement *)initWithTitle:(NSString *)string Value:(NSString *)param Placeholder:(NSString *)string1;
@end