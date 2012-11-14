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
    QSortingSection *section = (id)[_tableView.root getVisibleSectionForIndex:indexPath.section];
    return section.needsEditing && section.canDeleteRows && [section canRemoveElementForRow:indexPath.row] ? UITableViewCellEditingStyleDelete : UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}
- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    QSection * section = [_tableView.root getVisibleSectionForIndex:sourceIndexPath.section];
    NSIndexPath * first = [[section.elements objectAtIndex:section.beforeTemplateElements.count] getIndexPath];
    NSIndexPath * last = [[section.elements objectAtIndex:section.elements.count - section.afterTemplateElements.count - 1] getIndexPath];
    
    if (proposedDestinationIndexPath.section < sourceIndexPath.section)
        return first;
    if (proposedDestinationIndexPath.section > sourceIndexPath.section)
        return last;
    
    if (proposedDestinationIndexPath.row < first.row)
        return first;
    if (proposedDestinationIndexPath.row > last.row)
        return last;
    return proposedDestinationIndexPath;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    QSection *section = [_tableView.root getVisibleSectionForIndex:indexPath.section];
    QElement * element = [section getVisibleElementForIndex: indexPath.row];
    return [element getRowHeightForTableView:(QuickDialogTableView *) tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)index {
    QSection *section = [_tableView.root getVisibleSectionForIndex:index];

    if (section.headerView==nil && section.headerItems==nil && _tableView.styleProvider!=nil && [_tableView.styleProvider respondsToSelector:@selector(sectionHeaderWillAppearForSection:atIndex:)]){
        [_tableView.styleProvider sectionHeaderWillAppearForSection:section atIndex:index];
    }
    
    if (section.headerView!=nil)
        return section.headerView.frame.size.height;
    if (section.headerItems!=nil)
        return 44;
    
    if (section.title==nil)
        return 0;

    if (!_tableView.root.grouped)
        return 22.f;

    CGFloat stringTitleHeight = 0;

    if (section.title != nil) {
        CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width - 20;
        CGFloat maxHeight = 9999;
        CGSize maximumLabelSize = CGSizeMake(maxWidth,maxHeight);
        CGSize expectedLabelSize = [section.title sizeWithFont:[UIFont boldSystemFontOfSize:[UIFont labelFontSize]]
                                              constrainedToSize:maximumLabelSize
                                                  lineBreakMode:UILineBreakModeWordWrap];

        stringTitleHeight = expectedLabelSize.height+23.f;
    }


    return section.title != NULL? stringTitleHeight : 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)index {
    QSection *section = [_tableView.root getVisibleSectionForIndex:index];

    if (section.footerView==nil && section.footerItems == nil && _tableView.styleProvider!=nil && [_tableView.styleProvider respondsToSelector:@selector(sectionFooterWillAppearForSection:atIndex:)]){
        [_tableView.styleProvider sectionFooterWillAppearForSection:section atIndex:index];
    }
    
    if (section.footerView!=nil)
        return section.footerView.frame.size.height;
    
    if (section.footerItems!=nil)
        return 44;

    return section.footer != NULL? -1 : 0;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    QSection *section = [_tableView.root getVisibleSectionForIndex:indexPath.section];
    QElement *element = [section getVisibleElementForIndex: indexPath.row];
    if (_tableView.styleProvider != nil) {
        [_tableView.styleProvider cell:cell willAppearForElement:element atIndexPath:indexPath];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)index {
    QSection *section = [_tableView.root getVisibleSectionForIndex:index];
    UIView* view = [section getHeaderViewForTable:_tableView controller:_tableView.controller];
    
    if (view && [_tableView.styleProvider respondsToSelector:@selector(headerView:willAppearForSection:atIndex:)])
        [_tableView.styleProvider headerView:view willAppearForSection:section atIndex:index];
    
    return view;
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    QSection *sect = [_tableView.root getVisibleSectionForIndex:section];
    if ([_tableView.styleProvider respondsToSelector:@selector(headerView:willAppearForSection:atIndex:)])
        [_tableView.styleProvider headerView:view willAppearForSection:sect atIndex:section];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)index {
    QSection *section = [_tableView.root getVisibleSectionForIndex:index];
    UIView *view = [section getFooterViewForTable:_tableView controller:_tableView.controller];
    
    if (view && [_tableView.styleProvider respondsToSelector:@selector(footerView:willAppearForSection:atIndex:)])
        [_tableView.styleProvider footerView:view willAppearForSection:section atIndex:index];
    
    return view;
}
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section
{
    QSection *sect = [_tableView.root getVisibleSectionForIndex:section];
    if ([_tableView.styleProvider respondsToSelector:@selector(footerView:willAppearForSection:atIndex:)])
        [_tableView.styleProvider footerView:view willAppearForSection:sect atIndex:section];
}

@end