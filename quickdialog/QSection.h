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
#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

@class QRootElement;
@class QElement;

@interface QSection : NSObject {

    NSString *_key;
    NSString *_bind;

    CGRect _entryPosition;

@private
    __unsafe_unretained QRootElement *_rootElement;
    UIView *_headerView;
    UIView *_footerView;
}

@property(nonatomic, strong) NSString *key;
@property(nonatomic, retain) NSString *bind;

@property(nonatomic, retain) NSString *title;
@property(nonatomic, retain) NSString *footer;
@property(nonatomic, retain) NSMutableArray * elements;
@property(nonatomic, retain) NSMutableArray * beforeTemplateElements;
@property(nonatomic, retain) NSMutableArray * afterTemplateElements;

@property(nonatomic, assign) QRootElement *rootElement;

@property(nonatomic, readonly) BOOL needsEditing;

@property(nonatomic, retain) UIView *headerView;
@property(nonatomic, retain) NSString *headerImage;

@property(nonatomic, retain) UIView *footerView;
@property(nonatomic, retain) NSString *footerImage;

@property(nonatomic) CGRect entryPosition;
@property(nonatomic, strong) NSDictionary *elementTemplate;

@property(nonatomic, assign) BOOL hidden;
@property(nonatomic, readonly) NSUInteger visibleIndex;


/** * Called before a row is deleted to check on ability, and to handle the
 * disposal of the associated data object.
 * @property onDeleteRow Callback to perform safety check, and update data @note
 * The QElement will automatically be deleted by the QSection. If no callback is
 * provided, then YES is the default return, and no action is taken on the
 * bound data
 **/
@property(nonatomic, copy) BOOL (^onDeleteRow)(QElement* row);
@property(nonatomic, assign) BOOL canDeleteRows;
@property(nonatomic, strong) id object;


- (QSection *)initWithTitle:(NSString *)string;

- (void)addElement:(QElement *)element;
- (void)insertElement:(QElement *)element atIndex:(NSUInteger)index;
- (NSUInteger)indexOfElement:(QElement *)element;

- (BOOL)removeElementForRow:(NSUInteger)integer;
- (BOOL)canRemoveElementForRow:(NSUInteger)integer;

- (QElement *)getVisibleElementForIndex:(NSInteger)index;
- (NSInteger)visibleNumberOfElements;
- (NSUInteger)getVisibleIndexForElement:(QElement*)element;

- (void)bindToObject:(id)data;
- (void)fetchValueIntoObject:(id)obj;
- (void)fetchValueUsingBindingsIntoObject:(id)data;
@end
