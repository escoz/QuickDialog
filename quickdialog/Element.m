//
//  Created by escoz on 7/7/11.

#import "Element.h"
#import "QuickDialogController.h"
#import "QuickDialogTableView.h"
#import "Section.h"
#import "SortingSection.h"
#import "QuickDialogStyleProvider.h"


@implementation Element


@synthesize parentSection = _parentSection;
@synthesize key = _key;

@synthesize onSelected = _onSelected;
@synthesize controllerAction = _controllerAction;


- (Element *)initWithKey:(NSString *)key {
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
            [tableView.controller performSelector:selector withObject:self];
        }
    }
}

- (CGFloat)getRowHeightForTableView:(QuickDialogTableView *)tableView {
    return 44;
}

- (void)fetchValueIntoObject:(id)obj {
}

@end