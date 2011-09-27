//
//  QListPickerInlineElement.m
//  ZipMark
//
//  Created by Paul Newman on 9/26/11.
//  Copyright (c) 2011 Newman Zone. All rights reserved.
//

#import "QListPickerInlineElement.h"
#import "QListPickerTableViewCell.h"

@implementation QListPickerInlineElement

@synthesize centerLabel = _centerLabel;
@synthesize selectedItem = _selectedItem;
@synthesize selectedIndex = _selectedIndex;

- (QListPickerInlineElement *)init {
    self = [super init];
    return self;
}

- (QListPickerInlineElement *)initWithTitle:(NSString *)title list:(NSArray *)list {
    self = [super initWithTitle:title Value:[list objectAtIndex:0]];
    
    if (self!=nil){
        _dataProvider = list;
        _selectedItem = [list objectAtIndex:0];
    }
    return self;
}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {
    
    QListPickerTableViewCell *cell = (QListPickerTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"QuickformListPickerInlineElement"];
    if (cell==nil){
        cell = [[QListPickerTableViewCell alloc] init];
        [cell setList:_dataProvider];
    }
    [cell prepareForElement:self inTableView:tableView];
    return cell;
    
}

- (void)fetchValueIntoObject:(id)obj {
	if (_key==nil)
		return;
    [obj setValue:_selectedItem forKey:_key];
}

@end
