//
//  Created by escoz on 7/7/11.
//

#import "QElement.h"
#import "QRootElement.h"
#import "QSection.h"
#import "QuickDialogController.h"

@implementation QRootElement

@synthesize title = _title;
@synthesize sections = _sections;
@synthesize grouped = _grouped;
@synthesize controllerName = _controllerName;


- (void)addSection:(QSection *)section {
    if (_sections==nil)
        _sections = [[NSMutableArray alloc] init];

    [_sections addObject:section];
    section.rootElement = self;
}

- (QSection *)getSectionForIndex:(NSInteger)index {
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
    for (QSection *s in _sections){
        for (QElement *el in s.elements) {
            [el fetchValueIntoObject:obj];
        }
    }
}


@end