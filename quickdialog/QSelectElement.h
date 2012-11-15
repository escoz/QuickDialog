//
// Created by hivehicks on 10/17/12.
//
//  ${FILENAME}
//  QuickDialog
//
//  Created by ${FULLUSERNAME} on 10/17/12.
//  Copyright (c) 2012 ${ORGANIZATIONNAME}. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSComparisonResult (^QSelectItemsSortBlock)(id value1, id title1, id value2, id title2);


@interface QSelectElement : QEntryElement

@property (nonatomic, retain, readonly) NSIndexSet *selectedIndexes;
@property (nonatomic, copy) NSArray *selectedValues;

- (QSelectElement *)initWithItemTitles:(NSArray *)itemTitlesArray
                       selectedIndexes:(NSIndexSet *)selectedIndex
                                 title:(NSString *)title;

- (QSelectElement *)initWithDictionary:(NSDictionary *)valuesToTitlesDict
                        selectedValues:(NSArray *)selectedValues
                                 title:(NSString *)title;

- (QSelectElement *)initWithDictionary:(NSDictionary *)valuesToTitlesDict
                        selectedValues:(NSArray *)selectedValues
                             sortBlock:(QSelectItemsSortBlock)sortBlock
                                 title:(NSString *)title;

- (id)valueForIndex:(NSUInteger)index;
- (NSString *)titleForIndex:(NSUInteger)index;

- (void)selectItemAtIndex:(NSUInteger)index;
- (void)deselectItemAtIndex:(NSUInteger)index;

@end