//
//  Created by escoz on 7/8/11.
//
#import "QuickDialogTableDelegate.h"
#import "QuickDialogController.h"
#import "QElement.h"
#import "QSection.h"
#import "QSortingSection.h"
#import "QRootElement.h"
#import "QuickDialogTableView.h"


@implementation QuickDialogTableDelegate


- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QSection *section = [_tableView.root getSectionForIndex:indexPath.section];
    QElement * element = [section.elements objectAtIndex:(NSUInteger) indexPath.row];

    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    if (_tableView.selectedCell != selectedCell) {
        [_tableView.selectedCell resignFirstResponder];
        _tableView.selectedCell = selectedCell;
    }

    [element selected:_tableView controller:_tableView.controller indexPath:indexPath];
}

- (id<UITableViewDelegate, UIScrollViewDelegate>)initForTableView:(QuickDialogTableView *)tableView {
     self = [super init];
    if (self) {
       _tableView = tableView;
    }
    return self;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}
- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    BOOL isDestinationOK = [[_tableView.root getSectionForIndex:proposedDestinationIndexPath.section] isKindOfClass:[QSortingSection class]];
    return isDestinationOK ? proposedDestinationIndexPath : sourceIndexPath;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    QSection *section = [_tableView.root getSectionForIndex:indexPath.section];
QElement * element = [section.elements objectAtIndex:(NSUInteger) indexPath.row];
    return [element getRowHeightForTableView:(QuickDialogTableView *) tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)index {
    QSection *section = [_tableView.root getSectionForIndex:index];
    if (section.headerView!=nil)
            return section.headerView.frame.size.height;

    return section.title == NULL? 0 : _tableView.root.grouped? 44 :  22;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)index {
    QSection *section = [_tableView.root getSectionForIndex:index];
    if (section.footerView!=nil)
            return section.footerView.frame.size.height;

    return section.footer != NULL? 28 : 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)index {
    QSection *section = [_tableView.root getSectionForIndex:index];
    return section.headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)index {
    QSection *section = [_tableView.root getSectionForIndex:index];
    return section.footerView;
}


@end