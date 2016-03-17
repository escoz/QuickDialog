//
// Copyright 2012 Ludovic Landry - http://about.me/ludoviclandry
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
#import <UIKit/UIKit.h>
#import "QRootElement.h"
#import "QEntryElement.h"

@interface QImageElement : QEntryElement

@property (nonatomic, strong) UIImage *imageValue;
@property (nonatomic, strong) NSString *imageValueNamed;
@property (nonatomic, assign) float imageMaxLength;
@property(nonatomic) UIImagePickerControllerSourceType source;


- (QImageElement *)initWithTitle:(NSString *)title detailImage:(UIImage *)image;

@end
