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
#import "QElement.h"
#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

@class QRootElement;
@class QElement;

@interface QSection : NSObject {

    NSString *_key;
    CGRect _entryPosition;

@private
    QRootElement *_rootElement;
    UIView *_headerView;
    UIView *_footerView;
}

@property(nonatomic, strong) NSString *key;

@property(nonatomic, retain) NSString *title;
@property(nonatomic, retain) NSString *footer;

@property(nonatomic, retain) NSMutableArray * elements;
@property(nonatomic, retain) QRootElement *rootElement;

@property(nonatomic, readonly) BOOL needsEditing;

@property(nonatomic, retain) UIView *headerView;
@property(nonatomic, retain) UIView *footerView;
@property(nonatomic) CGRect entryPosition;

- (QSection *)initWithTitle:(NSString *)string;

- (void)addElement:(QElement *)element;

- (void)fetchValueIntoObject:(id)obj;

@end