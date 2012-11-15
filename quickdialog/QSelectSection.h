//
//  QSelectSection.h
//  QuickDialog
//
//  Created by HiveHicks on 23.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "QSection.h"

@protocol QSelectSectionDelegate;


@interface QSelectSection : QSection
{
    NSMutableArray *_items;
}

@property(nonatomic, strong)    NSArray         *items;
@property (nonatomic, strong)   NSMutableArray  *selectedIndexes;
@property (nonatomic, readonly) NSArray         *selectedItems;

@property (nonatomic, assign) id<QSelectSectionDelegate> delegate;

@property (nonatomic)           BOOL             multipleAllowed;

@property(nonatomic, copy) void (^onSelected)(void);

- (id)initWithItems:(NSArray *)stringArray selectedIndexes:(NSArray *)selected;
- (id)initWithItems:(NSArray *)stringArray selectedIndexes:(NSArray *)selected title:(NSString *)title;
- (id)initWithItems:(NSArray *)stringArray selectedItems:(NSArray *)selectedItems title:(NSString *)title;

- (id)initWithItems:(NSArray *)stringArray selected:(NSUInteger)selected;
- (id)initWithItems:(NSArray *)stringArray selected:(NSUInteger)selected title:(NSString *)title;

//- (QSelectElement *)initWithDictionary:(NSDictionary *)valuesToTitlesDict
//                        selectedValues:(NSArray *)selectedValues
//                                 title:(NSString *)title;
//
//- (QSelectElement *)initWithDictionary:(NSDictionary *)valuesToTitlesDict
//                        selectedValues:(NSArray *)selectedValues
//                             sortBlock:(QSelectItemsSortBlock)sortBlock
//                                 title:(NSString *)title;

- (void)addOption:(NSString *)option;
- (void)insertOption:(NSString *)option atIndex:(NSUInteger)index;

- (void)createElements;

@end


@protocol QSelectSectionDelegate <NSObject>

@optional
- (UIImage *)imageForItem:(id)item atIndex:(NSUInteger)index inSection:(QSelectSection *)section;

@end
