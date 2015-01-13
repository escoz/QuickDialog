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
@private
    id _object;
    NSString *_controllerAccessoryAction;
}

@synthesize enabled = _enabled;
@synthesize parentSection = _parentSection;
@synthesize key = _key;
@synthesize bind = _bind;

@synthesize onSelected = _onSelected;
@synthesize controllerAction = _controllerAction;
@synthesize object = _object;
@synthesize height = _height;
@synthesize hidden = _hidden;
@dynamic visibleIndex;
@synthesize controllerAccessoryAction = _controllerAccessoryAction;

@synthesize labelingPolicy = _labelingPolicy;

- (QElement *)init {
    self = [super init];
    if (self) {
        self.enabled = YES;
        self.shallowBind = YES;
    }
    return self;
}

- (QElement *)initWithKey:(NSString *)key {
    self = [super init];
    if (self){
        self.key = key;
        self.enabled = YES;
        self.shallowBind = YES;
    }
    return self;
}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {
    _controller = controller;
    
    QTableViewCell *cell= [self getOrCreateEmptyCell:tableView];

    [cell applyAppearanceForElement:self];

    cell.textLabel.text = nil; 
    cell.detailTextLabel.text = nil; 
    cell.imageView.image = nil; 
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.showsReorderControl = YES;
    cell.accessoryView = nil;
    cell.labelingPolicy = _labelingPolicy;
    return cell;
}

- (QTableViewCell *)getOrCreateEmptyCell:(QuickDialogTableView *)tableView {
    QTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"QuickformElementCell%@%@", self.key, self.class]];
    if (cell == nil){
        cell = [[QTableViewCell alloc] initWithReuseIdentifier:[NSString stringWithFormat:@"QuickformElementCell%@%@", self.key, NSStringFromClass(self.class)]];
    }
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
    _controller = controller;
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
    if (_onSelected!= nil)
        _onSelected();

    if (self.controllerAction!=NULL){
        SEL selector = NSSelectorFromString(self.controllerAction);
        if ([_controller respondsToSelector:selector]) {
			((void (*)(id, SEL, id)) objc_msgSend)(_controller, selector, self);
        }  else {
            NSLog(@"No method '%@' was found on controller %@", self.controllerAction, [_controller class]);
        }
    }
}

-(void)performAccessoryAction{
    if (_controller!=nil && self.controllerAccessoryAction!=nil) {
        SEL selector = NSSelectorFromString(self.controllerAccessoryAction);
        if ([_controller respondsToSelector:selector]) {
            ((void (*)(id, SEL, id)) objc_msgSend)(_controller, selector, self);
        }  else {
            NSLog(@"No method '%@' was found on controller %@", self.controllerAccessoryAction, [_controller class]);
        }
    }
}

@end
