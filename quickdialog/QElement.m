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

@implementation QElement {
@private
    NSObject *_object;
}
@synthesize parentSection = _parentSection;
@synthesize key = _key;

@synthesize onSelected = _onSelected;
@synthesize controllerAction = _controllerAction;
@synthesize object = _object;


- (QElement *)initWithKey:(NSString *)key {
    self = [super init];
    self.key = key;
    return self;

}
- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuickformElementCell"];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"QuickformElementCell"]; 
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.showsReorderControl = YES;
    cell.accessoryView = nil;
    return cell;
}

- (void)selected:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller indexPath:(NSIndexPath *)indexPath {
    [[tableView cellForRowAtIndexPath:indexPath] becomeFirstResponder];
    if (_onSelected!= nil)
          _onSelected();

    if (self.controllerAction!=NULL){
        SEL selector = NSSelectorFromString(self.controllerAction);
        if ([tableView.controller respondsToSelector:selector]) {
            objc_msgSend(tableView.controller ,selector, self);
        }  else {
            NSLog(@"No method '%@' was found on controller %@", self.controllerAction, [tableView.controller class]);
        }
    }
}

- (CGFloat)getRowHeightForTableView:(QuickDialogTableView *)tableView {
    return 44;
}

- (void)fetchValueIntoObject:(id)obj {
}

@end