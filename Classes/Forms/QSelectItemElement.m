//
//  QSelectItemElement.m
//  QuickDialog
//
//  Created by HiveHicks on 23.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "QSelectSection.h"
#import "QSelectItemElement.h"

@implementation QSelectItemElement {
    UIImage *_checkmarkImage;
}


- (instancetype)initWithIndex:(NSUInteger)index selectSection:(QSelectSection *)section
{
    if (self = [super init]) {
        self.selectSection = section;
        _index = index;
        _title = [self.selectSection.items[_index] description];
    }
    return self;
}

-(void)setCheckmarkImageNamed:(NSString *)name {
    if(name != nil) {
        self.checkmarkImage = [UIImage imageNamed:name];
    }
}

- (void)setCurrentCell:(UITableViewCell *)cell
{
    super.currentCell = cell;
    cell.selectionStyle = self.enabled ? UITableViewCellSelectionStyleBlue : UITableViewCellSelectionStyleNone;
    if ([self.selectSection.selectedIndexes containsObject:@(_index)] ) {
        [self updateCell:cell];
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
}


- (void)selected:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller indexPath:(NSIndexPath *)indexPath
{
    [super selected:tableView controller:controller indexPath:indexPath];
    
    NSNumber *numberIndex = @(_index);
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];

    if (self.selectSection.multipleAllowed)
    {
        if ([self.selectSection.selectedIndexes containsObject:numberIndex]) {
            selectedCell.accessoryType = UITableViewCellAccessoryNone;
            selectedCell.accessoryView = nil;
            [self.selectSection.selectedIndexes removeObject:numberIndex];
        } else {
            if (self.checkmarkImage==nil){
                selectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
            } else {
                UIImageView *view = [[UIImageView alloc] initWithImage:_checkmarkImage];
                [view sizeToFit];
                selectedCell.accessoryView = view;
            }
            [self.selectSection.selectedIndexes addObject:numberIndex];
        }
    }  else {
        if (![self.selectSection.selectedIndexes containsObject:numberIndex])
        {
            NSNumber *oldCellRowNumber = [self.selectSection.selectedIndexes count] > 0 ? self.selectSection.selectedIndexes[0] : nil;
            if (oldCellRowNumber)
            {
                UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:
                                            [NSIndexPath indexPathForRow:[oldCellRowNumber unsignedIntegerValue]
                                            inSection:indexPath.section]];
                
                oldCell.accessoryType = UITableViewCellAccessoryNone;
                oldCell.accessoryView = nil;
                [self.selectSection.selectedIndexes removeObject:oldCellRowNumber];
                [oldCell setNeedsDisplay];
            }
            [self updateCell:selectedCell];
            self.selectSection.selectedIndexes = @[numberIndex].mutableCopy;
        } else {
            if (self.selectSection.deselectAllowed) {
                [self.selectSection.selectedIndexes removeObject:numberIndex];
                selectedCell.accessoryType = UITableViewCellAccessoryNone;
                selectedCell.accessoryView = nil;
            }

        }
    }

    if (self.selectSection.onSelected) {
        self.selectSection.onSelected();
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
