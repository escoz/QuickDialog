//
//  QSelectItemElement.m
//  QuickDialog
//
//  Created by HiveHicks on 23.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "QSelectItemElement.h"

@implementation QSelectItemElement {
    NSUInteger _index;
    QSelectElement *_selectElement;
    QSelectSection *_selectSection;
}

- (QSelectItemElement *)initWithIndex:(NSUInteger)index selectElement:(QSelectElement *)element
{
    if (self = [super init]) {
        _selectElement = element;
        _index = index;
        _title = [_selectElement titleForIndex:_index];
    }
    return self;
}

- (QSelectItemElement *)initWithIndex:(NSUInteger)index selectSection:(QSelectSection *)section
{
    if (self = [super init]) {
        _selectSection = section;
        _index = index;
        _title = [[_selectSection.items objectAtIndex:_index] description];
    }
    return self;
}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller
{
    UITableViewCell *cell = [super getCellForTableView:tableView controller:controller];
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;

    BOOL selected =
            (_selectElement != nil)
                    ? [_selectElement.selectedIndexes containsIndex:_index]
                    : [_selectSection.selectedIndexes containsObject:@(_index)];

    cell.accessoryType = selected ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;

    if (_selectSection.delegate && [_selectSection.delegate respondsToSelector:@selector(imageForItem:atIndex:inSection:)])
    {
        UIImage *itemImage =
                [_selectSection.delegate imageForItem:[_selectSection.items objectAtIndex:_index]
                                              atIndex:_index
                                            inSection:_selectSection];

        if (itemImage) {
            cell.imageView.image = itemImage;
        }
    }
    
    return cell;
}

- (void)selected:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller indexPath:(NSIndexPath *)indexPath
{
    [super selected:tableView controller:controller indexPath:indexPath];
    
    NSNumber *numberIndex = @(_index);
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];

    if (_selectElement != nil)
    {
        if ([_selectElement.selectedIndexes containsIndex:_index]) {
            selectedCell.accessoryType = UITableViewCellAccessoryNone;
            [_selectElement deselectItemAtIndex:_index];
        } else {
            selectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
            [_selectElement selectItemAtIndex:_index];
        }

        if (_selectElement.onSelected) {
            _selectElement.onSelected();
        }
    }
    else if (_selectSection != nil)
    {
        if (_selectSection.multipleAllowed)
        {
            if ([_selectSection.selectedIndexes containsObject:numberIndex]) {
                selectedCell.accessoryType = UITableViewCellAccessoryNone;
                [_selectSection.selectedIndexes removeObject:numberIndex];
            } else {
                selectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
                [_selectSection.selectedIndexes addObject:numberIndex];
            }
        }
        else
        {
            if (![_selectSection.selectedIndexes containsObject:numberIndex])
            {
                NSNumber *oldCellRowNumber = [_selectSection.selectedIndexes count] > 0 ? [_selectSection.selectedIndexes objectAtIndex:0] : nil;
                if (oldCellRowNumber)
                {
                    UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:
                                                                  [NSIndexPath indexPathForRow:[oldCellRowNumber unsignedIntegerValue]
                                                                                     inSection:indexPath.section]];

                    oldCell.accessoryType = UITableViewCellAccessoryNone;
                    [_selectSection.selectedIndexes removeObject:oldCellRowNumber];
                    [oldCell setNeedsDisplay];
                }

                selectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
                [_selectSection.selectedIndexes addObject:numberIndex];
            }
        }

        if (_selectSection.onSelected) {
            _selectSection.onSelected();
        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
