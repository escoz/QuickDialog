//
// Created by hivehicks on 10/17/12.
//
//  ${FILENAME}
//  QuickDialog
//
//  Created by ${FULLUSERNAME} on 10/17/12.
//  Copyright (c) 2012 ${ORGANIZATIONNAME}. All rights reserved.
//

#import "QSelectElement.h"


@implementation QSelectElement {
    QSection *_internalRadioItemsSection;
    NSDictionary *_valuesToTitlesDict;
    NSArray *_sortedValues;
    QSelectItemsSortBlock _sortBlock;
}

@synthesize selectedValues = _selectedValues;

- (QSelectElement *)initWithDictionary:(NSDictionary *)valuesToTitlesDict
                        selectedValues:(NSArray *)selectedValues
                             sortBlock:(QSelectItemsSortBlock)sortBlock
                                 title:(NSString *)title
{
    if (self = [super initWithTitle:title Value:nil Placeholder:nil])
    {
        _valuesToTitlesDict = valuesToTitlesDict ? valuesToTitlesDict : @{};
        _selectedValues = selectedValues ? [selectedValues copy] : @[];

        _sortBlock = sortBlock ? _sortBlock : ^(id key1, id value1, id key2, id value2) {
            return [key1 compare:key2];
        };

        _sortedValues = [[_valuesToTitlesDict allKeys] sortedArrayUsingComparator:^(id key1, id key2) {
            return _sortBlock(key1, [_valuesToTitlesDict objectForKey:key1], key2, [_valuesToTitlesDict objectForKey:key2]);
        }];

        [self createElements];
    }

    return self;
}

- (id)valueForIndex:(NSUInteger)index
{
    return (index < _sortedValues.count) ? [_sortedValues objectAtIndex:index] : nil;
}

- (NSString *)titleForIndex:(NSUInteger)index
{
    id value = [self valueForIndex:index];
    return (value != nil) ? [[_valuesToTitlesDict objectForKey:value] description] : nil;
}

- (QSelectElement *)initWithDictionary:(NSDictionary *)valuesToTitlesDict
                        selectedValues:(NSArray *)selectedValues
                                 title:(NSString *)title
{
    return [self initWithDictionary:valuesToTitlesDict selectedValues:selectedValues sortBlock:nil title:title];
}

- (QSelectElement *)initWithItemTitles:(NSArray *)itemTitlesArray
                       selectedIndexes:(NSIndexSet *)selectedIndexes
                                 title:(NSString *)title
{
    NSMutableDictionary *valuesToTitlesDict = [NSMutableDictionary new];
    [itemTitlesArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [valuesToTitlesDict setObject:obj forKey:@(idx)];
    }];

    NSMutableArray *selectedValues = [NSMutableArray new];
    [selectedIndexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        if (idx < valuesToTitlesDict.count) {
            [selectedValues addObject:@(idx)];
        }
    }];

    return [self initWithDictionary:valuesToTitlesDict selectedValues:selectedValues title:title];
}

- (void)createElements
{
    _sections = nil;
    _internalRadioItemsSection = [[QSection alloc] init];
    _parentSection = _internalRadioItemsSection;

    [self addSection:_parentSection];

    for (NSUInteger i = 0; i < [_sortedValues count]; i++) {
        [_parentSection addElement:[[QSelectItemElement alloc] initWithIndex:i selectElement:self]];
    }
}

- (NSIndexSet *)selectedIndexes
{
    NSMutableIndexSet *indexSet = [NSMutableIndexSet new];

    [_selectedValues enumerateObjectsUsingBlock:^(id value, NSUInteger i, BOOL *stop) {
        NSUInteger index = [_sortedValues indexOfObject:value];
        if (index != NSNotFound) {
            [indexSet addIndex:index];
        }
    }];

    return indexSet;
}

- (void)selectItemAtIndex:(NSUInteger)index
{
    id value = [self valueForIndex:index];
    if (value) {
        _selectedValues = [_selectedValues arrayByAddingObject:value];
    }
}

- (void)deselectItemAtIndex:(NSUInteger)index
{
    id value = [self valueForIndex:index];
    if (value) {
        NSMutableArray *mutableValues = [_selectedValues mutableCopy];
        [mutableValues removeObject:value];
        _selectedValues = [NSArray arrayWithArray:mutableValues];
    }
}

- (void)setSelectedIndexes:(NSIndexSet *)selectedIndexes
{
    NSMutableArray *selectedValues = [NSMutableArray new];

    [selectedIndexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        if (idx < _sortedValues.count) {
            [selectedValues addObject:[_sortedValues objectAtIndex:idx]];
        }
    }];

    _selectedValues = selectedValues;
}

- (void)selected:(QuickDialogTableView *)tableView
      controller:(QuickDialogController *)controller
       indexPath:(NSIndexPath *)path
{
    if (self.sections != nil) {
        [controller displayViewControllerForRoot:self];
    }
}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView
                              controller:(QuickDialogController *)controller
{
    QEntryTableViewCell *cell = (QEntryTableViewCell *) [super getCellForTableView:tableView controller:controller];

    NSString *selectedValue = [NSString stringWithFormat:@"%d %@", _selectedValues.count, NSLocalizedString(@"items", nil)];

    if (self.title == NULL) {
        cell.textField.text = selectedValue;
        cell.detailTextLabel.text = nil;
        cell.imageView.image = nil;
    } else {
        cell.textField.text = selectedValue;
        cell.textLabel.text = _title;
        cell.imageView.image = nil;
    }

    cell.textField.textAlignment = UITextAlignmentRight;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    cell.textField.userInteractionEnabled = NO;

    return cell;
}

-(void)setSelected:(NSInteger)index
{
    if (index < _sortedValues.count) {
        _selectedValues = [_selectedValues arrayByAddingObject:[_sortedValues objectAtIndex:index]];
    }
}

- (void)fetchValueIntoObject:(id)obj
{
	if (_key == nil) {
		return;
    }

    if (_selectedValues.count > 0) {
        [obj setValue:_selectedValues forKey:_key];
    }
}

- (BOOL)canTakeFocus
{
    return NO;
}

@end