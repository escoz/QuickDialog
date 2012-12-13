//
//  QSelectElement.m
//  DealerFire2
//
//  Created by M.Y. on 12/12/12.
//  Copyright (c) 2012 DealerFire. All rights reserved.
//

#import "QSelectElement.h"
#import "QSelectSection.h"

@interface QSelectElement()
@property (strong, nonatomic) QSelectSection *selectSection;
@property (strong, nonatomic) NSMutableArray *selectedIndexes;

@end

@implementation QSelectElement

- (id)initWithItems:(NSArray *)items selectedIndexes:(NSArray *)selected {
    self = [super init];
    if (self) {
        self.selectedIndexes = [NSMutableArray arrayWithArray: selected];
        self.items = items;
    }
    return self;
}

- (void)createElements {
    _sections = nil;
    
    self.selectSection = [[QSelectSection alloc] initWithItems: self.items selectedIndexes: self.selectedIndexes];
    self.selectSection.multipleAllowed = YES;
    _parentSection = self.selectSection;
    
    [self addSection:_parentSection];
    
}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {
    QEntryTableViewCell *cell = (QEntryTableViewCell *) [super getCellForTableView:tableView controller:controller];
    
    NSString *selectedValue = nil;
    
    selectedValue = [self.selectSection.selectedItems componentsJoinedByString: @", "];
    
    if (self.title == NULL){
        cell.textField.text = selectedValue;
        cell.detailTextLabel.text = nil;
        cell.imageView.image = nil;
    } else {
        cell.textLabel.text = _title;
        cell.textField.text = selectedValue;
        cell.imageView.image = nil;
    }
    cell.textField.textAlignment = UITextAlignmentRight;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    cell.textField.userInteractionEnabled = NO;
    return cell;
}

@end
