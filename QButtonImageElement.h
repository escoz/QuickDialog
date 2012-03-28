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

#import "QLabelElement.h"
#import "QButtonImageColours.h"

@interface QButtonImageElement : QLabelElement {
@private
}

@property (nonatomic, retain) UIImage* image;
@property (nonatomic) BOOL disabled;
@property (nonatomic) CGFloat height;
@property (nonatomic, retain) UIImage* baseImage;
@property (nonatomic, retain) QButtonImageColours* colours;

- (QButtonImageElement *)init;

- (QButtonImageElement *)initWithTitle:(NSString *)title andImage:(UIImage*)theImage withRowHeight:(CGFloat)rowHeight;

- (QButtonImageElement *)initWithTitleAndColours:(NSString *)title andImage:(UIImage*)theImage withRowHeight:(CGFloat)rowHeight andColours:(QButtonImageColours*)theColours;

- (void)setRowHeight:(CGFloat)theHeight;

- (void)disable;

- (void)enable;

- (BOOL)isDisabled;

- (void)setTheColours:(QButtonImageColours*)theColours;

@end
