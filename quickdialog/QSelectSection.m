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

- (QSelectSection *)initWithItems:(NSArray *)stringArray selectedIndexes:(NSArray *)selected
{
    return [self initWithItems:stringArray selectedIndexes:selected title:nil];
}

- (QSelectSection *)initWithItems:(NSArray *)stringArray selectedIndexes:(NSArray *)selected title:(NSString *)title
{
    if (self = [super initWithTitle:title])
    {
        _items = stringArray;
        _selected = selected ? [selected mutableCopy] : [NSMutableArray array];
        _multipleAllowed = (_selected.count > 1);
    
        [self createElements];
    }
    
    return self;
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
    _items = items;
    self.elements = nil;
    [self createElements];
}

- (void)createElements
{
    for (NSUInteger i = 0; i < [_items count]; i++) {
        [self addElement:[[QSelectItemElement alloc] initWithIndex:i selectSection:self]];
    }
}

- (void)fetchValueIntoObject:(id)obj
{
    if (_key) {
		[obj setValue:_selected forKey:_key];
    }
}

@end
