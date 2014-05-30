//
//  QSelectSection.h
//  QuickDialog
//
//  Created by HiveHicks on 23.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <QuickDialog/QuickDialog.h>


@interface QSelectSection : QDynamicDataSection
{
    NSMutableArray *_items;
}

@property(nonatomic, strong)    NSArray         *items;
@property (nonatomic, strong)   NSMutableArray  *selectedIndexes;
@property (nonatomic, readonly) NSArray         *selectedItems;
@property (nonatomic)           BOOL             multipleAllowed;

@property(nonatomic, copy) void (^onSelected)(void);


@property(nonatomic) BOOL deselectAllowed;

- (instancetype)initWithItems:(NSArray *)stringArray selectedIndexes:(NSArray *)selected;
- (instancetype)initWithItems:(NSArray *)stringArray selectedIndexes:(NSArray *)selected title:(NSString *)title;
- (instancetype)initWithItems:(NSArray *)stringArray selectedItems:(NSArray *)selectedItems title:(NSString *)title;

- (instancetype)initWithItems:(NSArray *)stringArray selected:(NSUInteger)selected;
- (instancetype)initWithItems:(NSArray *)stringArray selected:(NSUInteger)selected title:(NSString *)title;

- (void)addOption:(NSString *)option;
- (void)insertOption:(NSString *)option atIndex:(NSUInteger)index;

- (void)createElements;

@end
