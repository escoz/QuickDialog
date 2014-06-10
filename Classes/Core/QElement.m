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

#import <objc/message.h>
#import "QBindingEvaluator.h"
#import "QElement.h"
#import "QuickDialog.h"

@implementation QElement {
}

@dynamic visibleIndex;

- (instancetype)init {
    self = [super init];
    if (self) {
        [self internalInit];
        self.cellClass = [QTableViewCell class];
    }
    return self;
}

- (void)internalInit
{
    self.enabled = YES;
    self.shallowBind = YES;
    self.height = 44;
}

- (instancetype)initWithKey:(NSString *)key {
    self = [super init];
    if (self){
        [self internalInit];
    }
    return self;
}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"QD_%@_%@", self.key, self.cellClass]];
    if (cell == nil) {
        cell = [self createNewCell:tableView];
    }

    self.currentCell = cell;
    self.currentTableView = tableView;
    self.currentController = controller;

    if ([cell respondsToSelector:@selector(applyAppearanceForElement:)])
        [cell performSelector:@selector(applyAppearanceForElement:) withObject:self];

    return cell;
}

- (void)setCurrentCell:(UITableViewCell *)currentCell
{
    _currentCell = currentCell;
    if ([_currentCell respondsToSelector:@selector(setCurrentElement:)])
        [_currentCell performSelector:@selector(setCurrentElement:) withObject:self];
}


- (QTableViewCell *)createNewCell:(QuickDialogTableView *)tableView {
    QTableViewCell *cell = (QTableViewCell *) [self.cellClass alloc];
    cell = [cell initWithReuseIdentifier:[NSString stringWithFormat:@"QD_%@_%@", self.key, NSStringFromClass(self.class)]];
    return cell;
}


- (void)selectedAccessory:(QuickDialogTableView *)tableView  controller:(QuickDialogController *)controller indexPath:(NSIndexPath *)indexPath{
    if (self.controllerAccessoryAction!=NULL){
            SEL selector = NSSelectorFromString(self.controllerAccessoryAction);
            if ([controller respondsToSelector:selector]) {
                ((void (*)(id, SEL, id)) objc_msgSend)(controller, selector, self);
            }  else {
                NSLog(@"No method '%@' was found on controller %@", self.controllerAccessoryAction, [controller class]);
            }
        }
}

- (void)selected:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller indexPath:(NSIndexPath *)indexPath {
    self.currentController = controller;

    [[tableView cellForRowAtIndexPath:indexPath] becomeFirstResponder];
    [self performAction];
}

- (CGFloat)getRowHeightForTableView:(QuickDialogTableView *)tableView {
    return _height > 0 ? _height : 44;
}

- (NSUInteger) visibleIndex
{
    return [self.parentSection getVisibleIndexForElement:self];
}
- (NSIndexPath*) getIndexPath
{
    if (self.hidden || _parentSection.hidden)
        return nil;
    return [NSIndexPath indexPathForRow:self.visibleIndex inSection:_parentSection.visibleIndex];
}
- (void)fetchValueIntoObject:(id)obj {
}

-(void)bindToObject:(id)data withString:(NSString *)string{
    [[QBindingEvaluator new] bindObject:self toData:data withString:string];
}

-(void)bindToObject:(id)data {
    [[QBindingEvaluator new] bindObject:self toData:data];
}


- (void)bindToObject:(id)data shallow:(BOOL)shallow
{
    [[QBindingEvaluator new] bindObject:self toData:data];
}

- (void)fetchValueUsingBindingsIntoObject:(id)data {
    [[QBindingEvaluator new] fetchValueFromObject:self toData:data];
}

- (void)performAction
{

    if ((self.currentController != nil && self.controllerAction != nil) || _onSelected != nil) {
        if (_onSelected!= nil)
            _onSelected();

        if (self.controllerAction!=NULL){
            SEL selector = NSSelectorFromString(self.controllerAction);
            if ([self.currentController respondsToSelector:selector]) {
                ((void (*)(id, SEL, id)) objc_msgSend)(self.currentController, selector, self);
            }  else {
                NSLog(@"No method '%@' was found on controller %@", self.controllerAction, [self.currentController class]);
            }
        }
    }
}

-(void)performAccessoryAction{
    if (self.currentController !=nil && self.controllerAccessoryAction!=nil) {
        SEL selector = NSSelectorFromString(self.controllerAccessoryAction);
        if ([self.currentController respondsToSelector:selector]) {
            ((void (*)(id, SEL, id)) objc_msgSend)(self.currentController, selector, self);
        }  else {
            NSLog(@"No method '%@' was found on controller %@", self.controllerAccessoryAction, [self.currentController class]);
        }
    }
}

@end
