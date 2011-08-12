//
//  Created by escoz on 7/7/11.
//

#import "Element.h"
#import "RootElement.h"
#import "Section.h"
#import "QuickDialogController.h"

@implementation RootElement

@synthesize title = _title;
@synthesize sections = _sections;
@synthesize grouped = _grouped;
@synthesize controllerName = _controllerName;


- (void)addSection:(Section *)section {
    if (_sections==nil)
        _sections = [[NSMutableArray alloc] init];

    [_sections addObject:section];
    section.rootElement = self;
}

- (Section *)getSectionForIndex:(NSInteger)index {
   return [_sections objectAtIndex:(NSUInteger) index];
}

- (NSInteger)numberOfSections {
    return [_sections count];
}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {
    UITableViewCell *cell = [super getCellForTableView:tableView controller:controller];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    cell.textLabel.text = _title;
    return cell;
}

- (void)selected:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller indexPath:(NSIndexPath *)path {
    [super selected:tableView controller:controller indexPath:path];

    if (self.sections==nil)
            return;

    [controller displayViewControllerForRoot:self];
}

- (void)fetchValueIntoObject:(id)obj {
    for (Section *s in _sections){
        for (Element *el in s.elements) {
            [el fetchValueIntoObject:obj];
        }
    }
}


@end