//
//  QSelectItemElement.m
//  QuickDialog
//
//  Created by HiveHicks on 23.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#import "QuickDialogController.h"
#import <UIKit/UIKit.h>
#import "QSelectItemElement.h"
#import "QAppearance.h"
#import "QElement+Appearance.h"

@implementation QSelectItemElement {
    UIImage *_checkmarkImage;
}
@synthesize selectSection = _selectSection;
@synthesize index = _index;
@synthesize checkmarkImage = _checkmarkImage;


- (QSelectItemElement *)initWithIndex:(NSUInteger)index selectSection:(QSelectSection *)section
{
    if (self = [super init]) {
        _selectSection = section;
        _index = index;
        _title = [[_selectSection.items objectAtIndex:_index] description];
    }
    return self;
}

-(void)setCheckmarkImageNamed:(NSString *)name {
    if(name != nil) {
        self.checkmarkImage = [UIImage imageNamed:name];
    }
}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller
{
    UITableViewCell *cell = [super getCellForTableView:tableView controller:controller];
    cell.selectionStyle = self.enabled ? UITableViewCellSelectionStyleBlue : UITableViewCellSelectionStyleNone;
    if ([_selectSection.selectedIndexes containsObject:[NSNumber numberWithUnsignedInteger:_index]] ) {
        [self updateCell:cell];
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)selected:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller indexPath:(NSIndexPath *)indexPath
{
    [super selected:tableView controller:controller indexPath:indexPath];
    
    NSNumber *numberIndex = [NSNumber numberWithUnsignedInteger:_index];
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];

    if (_selectSection.multipleAllowed)
    {
        if ([_selectSection.selectedIndexes containsObject:numberIndex]) {
            selectedCell.accessoryType = UITableViewCellAccessoryNone;
            selectedCell.accessoryView = nil;
            [_selectSection.selectedIndexes removeObject:numberIndex];
        } else {
            if (self.checkmarkImage==nil){
                selectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
            } else {
                UIImageView *view = [[UIImageView alloc] initWithImage:_checkmarkImage];
                [view sizeToFit];
                selectedCell.accessoryView = view;
            }
            [_selectSection.selectedIndexes addObject:numberIndex];
        }
    }  else {
        if (![_selectSection.selectedIndexes containsObject:numberIndex])
        {
            NSNumber *oldCellRowNumber = [_selectSection.selectedIndexes count] > 0 ? [_selectSection.selectedIndexes objectAtIndex:0] : nil;
            if (oldCellRowNumber)
            {
                UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:
                                            [NSIndexPath indexPathForRow:[oldCellRowNumber unsignedIntegerValue]
                                            inSection:indexPath.section]];
                
                oldCell.accessoryType = UITableViewCellAccessoryNone;
                oldCell.accessoryView = nil;
                [_selectSection.selectedIndexes removeObject:oldCellRowNumber];
                [oldCell setNeedsDisplay];
            }
            [self updateCell:selectedCell];
            [_selectSection.selectedIndexes addObject:numberIndex];
        } else {
            if (_selectSection.deselectAllowed) {
                [_selectSection.selectedIndexes removeObject:numberIndex];
                selectedCell.accessoryType = UITableViewCellAccessoryNone;
                selectedCell.accessoryView = nil;
            }

        }
    }

    if (_selectSection.onSelected) {
        _selectSection.onSelected();
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)updateCell:(UITableViewCell *)selectedCell {
    if (self.checkmarkImage ==nil){
        selectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
        selectedCell.accessoryView = nil;
    } else {
        selectedCell.accessoryType = UITableViewCellAccessoryNone;
        UIImageView *view = [[UIImageView alloc] initWithImage:_checkmarkImage];
        [view sizeToFit];
        selectedCell.accessoryView = view;
    }
}

@end
