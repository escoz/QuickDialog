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

#import <sys/ucred.h>
#import "QuickDialogTableDelegate.h"
#import "QuickDialog.h"
@implementation QuickDialogTableDelegate


- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    QSection *section = [_tableView.root getVisibleSectionForIndex:indexPath.section];
    QElement * element = [section getVisibleElementForIndex: indexPath.row];

    [element selectedAccessory:_tableView controller:_tableView.controller indexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QSection *section = [_tableView.root getVisibleSectionForIndex:indexPath.section];
    QElement * element = [section getVisibleElementForIndex: indexPath.row];

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
    QSection *section = [_tableView.root getVisibleSectionForIndex:indexPath.section];
    return section.canDeleteRows ? UITableViewCellEditingStyleDelete : UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}
- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    BOOL isDestinationOK = [[_tableView.root getVisibleSectionForIndex:proposedDestinationIndexPath.section] isKindOfClass:[QSortingSection class]];
    return isDestinationOK ? proposedDestinationIndexPath : sourceIndexPath;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    QSection *section = [_tableView.root getVisibleSectionForIndex:indexPath.section];
    QElement * element = [section getVisibleElementForIndex: indexPath.row];
    return [element getRowHeightForTableView:(QuickDialogTableView *) tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)index {
    QSection *section = [_tableView.root getVisibleSectionForIndex:index];
    return [_tableView.root.appearance heightForHeaderInSection:section andTableView:_tableView andIndex:index];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)index {
    QSection *section = [_tableView.root getVisibleSectionForIndex:index];
    return [_tableView.root.appearance heightForFooterInSection:section andTableView:_tableView andIndex:index];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    QSection *section = [_tableView.root getVisibleSectionForIndex:indexPath.section];
    QElement *element = [section getVisibleElementForIndex: indexPath.row];
    [_tableView.root.appearance cell:cell willAppearForElement:element atIndexPath:indexPath];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)index {
    QSection *section = [_tableView.root getVisibleSectionForIndex:index];
    if (section.headerView!=nil)
        return section.headerView;

    QAppearance *appearance = ((QuickDialogTableView *) tableView).root.appearance;
    return [appearance buildHeaderForSection:section andTableView:(QuickDialogTableView*)tableView andIndex:index];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)index {
    QSection *section = [_tableView.root getVisibleSectionForIndex:index];
    if (section.footerView!=nil)
        return section.footerView;

    QAppearance *appearance = ((QuickDialogTableView *) tableView).root.appearance;
    return [appearance buildFooterForSection:section andTableView:(QuickDialogTableView*)tableView andIndex:index];

}


@end
