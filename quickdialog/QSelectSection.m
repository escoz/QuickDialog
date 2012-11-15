//
//  QSelectSection.m
//  QuickDialog
//
//  Created by HiveHicks on 23.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "QSelectSection.h"

@implementation QSelectSection

@synthesize selectedIndexes = _selected;
@synthesize multipleAllowed = _multipleAllowed;
@synthesize onSelected = _onSelected;

- (QSelectSection *)initWithItems:(NSArray *)stringArray selectedIndexes:(NSArray *)selected
{
    return [self initWithItems:stringArray selectedIndexes:selected title:nil];
}

- (QSelectSection *)initWithItems:(NSArray *)stringArray selectedIndexes:(NSArray *)selected title:(NSString *)title
{
    if (self = [super initWithTitle:title])
    {
        _items = [stringArray mutableCopy];
        _selected = selected ? [selected mutableCopy] : [NSMutableArray array];
        _multipleAllowed = (_selected.count > 1);
    
        [self createElements];
    }
    
    return self;
}

- (QSelectSection *)initWithItems:(NSArray *)items selectedItems:(NSArray *)selectedItems title:(NSString *)title
{
    NSMutableArray *selectedIndexes = [NSMutableArray array];
    for (id item in selectedItems) {
        NSUInteger index = [items indexOfObject:item];
        if (index != NSNotFound) {
            [selectedIndexes addObject:[NSNumber numberWithUnsignedInteger:index]];
        }
    }
    
    return [self initWithItems:items selectedIndexes:selectedIndexes title:title];
}

- (QSelectSection *)initWithItems:(NSArray *)stringArray selected:(NSUInteger)selected
{
    return [self initWithItems:stringArray selected:selected title:nil];
}

- (QSelectSection *)initWithItems:(NSArray *)stringArray selected:(NSUInteger)selected title:(NSString *)title
{
    return [self initWithItems:stringArray
               selectedIndexes:[NSArray arrayWithObject:[NSNumber numberWithUnsignedInteger:selected]]
                         title:title];
}

- (NSArray *)items
{
    return _items;
}

- (void)setItems:(NSArray *)items
{
    _items = [items mutableCopy];
    self.elements = nil;
    [self createElements];
}

- (NSArray *)selectedItems
{
    NSMutableArray *selectedItems = [NSMutableArray array];
    for (NSNumber *index in _selected) {
        [selectedItems addObject:[_items objectAtIndex:[index unsignedIntegerValue]]];
    }
    return selectedItems;
}

- (void)createElements
{
    for (NSUInteger i = 0; i < [_items count]; i++) {
        [self addElement:[[QSelectItemElement alloc] initWithIndex:i selectSection:self]];
    }
}

- (void)addOption:(NSString *)option
{
    [self insertOption:option atIndex:_items.count];
}

- (void)insertOption:(NSString *)option atIndex:(NSUInteger)index
{
    [_items insertObject:option atIndex:index];
    QSelectItemElement *element = [[QSelectItemElement alloc] initWithIndex:index selectSection:self];
    [self insertElement:element atIndex:index];
}

- (void)fetchValueIntoObject:(id)obj
{
    if (_key) {
		[obj setValue:_selected forKey:_key];
    }
}

@end
