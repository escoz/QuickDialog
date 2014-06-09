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

#import "QSection.h"
#import "QSortingSection.h"
#import "QElement.h"
#import "NSMutableArray+MoveObject.h"

@implementation QSortingSection {

}


@synthesize sortingEnabled = _sortingEnabled;
@synthesize canDeleteRows = _canDeleteRows;


- (QSortingSection *)init {
    self = [super init];
    self.sortingEnabled = YES;
    return self;
}

- (QSortingSection *)initWithItems:(NSArray *)stringArray selectedIndexes:(NSArray *)selected
{
    return [self initWithItems:stringArray selectedIndexes:selected title:nil];
}

- (QSortingSection *)initWithItems:(NSArray *)stringArray selectedIndexes:(NSArray *)selected title:(NSString *)title
{
    if (self = [super initWithTitle:title])
    {
        _items = [stringArray mutableCopy];
//        _selected = selected ? [selected mutableCopy] : [NSMutableArray array];
//        _multipleAllowed = (_selected.count > 1);
        
        [self createElements];
    }
    
    return self;
}

- (QSortingSection *)initWithItems:(NSArray *)items selectedItems:(NSArray *)selectedItems title:(NSString *)title
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

- (QSortingSection *)initWithItems:(NSArray *)stringArray selected:(NSUInteger)selected
{
    return [self initWithItems:stringArray selected:selected title:nil];
}

- (QSortingSection *)initWithItems:(NSArray *)stringArray selected:(NSUInteger)selected title:(NSString *)title
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

- (void)createElements
{
    for (NSUInteger i = 0; i < [_items count]; i++) {
        [self addElement:[[QSelectItemElement alloc] initWithTitle:[_items[i] description] Value:@""]];
    }
}

- (BOOL)needsEditing {
    return _sortingEnabled;
}

- (void)fetchValueIntoObject:(id)obj {
    if (_key == nil)
       return;

    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (QElement *el in self.elements){
        [result addObject:el.key];
    }
    [obj setValue:result forKey:_key];
}

- (void)moveElementFromRow:(NSUInteger)from toRow:(NSUInteger)to {
    [self.elements moveObjectFromIndex:from toIndex:to];
}

- (BOOL)removeElementForRow:(NSInteger)index {
    [self.elements removeObjectAtIndex:(NSUInteger) index];
    return YES;

}

- (BOOL)canRemoveElementForRow:(NSInteger)integer {
    return YES;
}
@end
