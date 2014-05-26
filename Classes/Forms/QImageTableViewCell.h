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

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "QEntryTableViewCell.h"

@class QImageElement;
@class QuickDialogTableView;

@interface QImageTableViewCell : QEntryTableViewCell {

   QImageElement *_imageElement;
   UIButton *_imageViewButton;
}

@property (nonatomic, retain) UIButton *imageViewButton;

- (void)prepareForElement:(QEntryElement *)element inTableView:(QuickDialogTableView *)tableView;
- (void)createSubviews;

@end
