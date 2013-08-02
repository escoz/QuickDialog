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

#import "QTableViewCell.h"

@class QSection;
@class QuickDialogTableView;
@class QuickDialogController;

/**

  QElement – an element object maps one-to-one map to a UITableViewCell, although it includes more functionality, like being able to read values from the cells and having multiple types. QuickDialog provides many different built-in element types, like the ButtonElement and the EntryElement, but you can also create your custom one.

*/

@interface QElement : NSObject {

@protected
    __unsafe_unretained QSection *_parentSection;
    NSString *_key;
    NSString *_bind;
	
	CGFloat _height;
    BOOL _hidden;

    void (^_onSelected)(void);
    NSString * _controllerAction;
}

@property (nonatomic, assign, getter=isEnabled) BOOL enabled;

@property(nonatomic, copy) void (^onSelected)(void);
@property(nonatomic, retain) NSString *controllerAction;
@property(nonatomic, retain) NSString *controllerAccessoryAction;

@property(nonatomic) CGFloat height;
@property(nonatomic) BOOL    hidden;
@property(nonatomic,readonly) NSUInteger visibleIndex;

@property(nonatomic, assign) QSection *parentSection;

@property(nonatomic, retain) NSString *key;
@property(nonatomic, retain) id object;
@property(nonatomic, retain) NSString *bind;

@property (nonatomic) QLabelingPolicy labelingPolicy;

- (QElement *)initWithKey:(NSString *)key;

- (NSIndexPath*) getIndexPath;

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller;

-(QTableViewCell *)getOrCreateEmptyCell:(QuickDialogTableView *)tableView;

- (void)handleElementSelected:(QuickDialogController *)controller;

- (void)selectedAccessory:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller indexPath:(NSIndexPath *)indexPath;


- (void)selected:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller indexPath:(NSIndexPath *)indexPath;

- (CGFloat)getRowHeightForTableView:(QuickDialogTableView *)tableView;

- (void)fetchValueIntoObject:(id)obj;

- (void)bindToObject:(id)obj;

- (void)fetchValueUsingBindingsIntoObject:(id)object;


@end
