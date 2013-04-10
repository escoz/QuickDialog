#import <Foundation/Foundation.h>
#import "QuickDialogController.h"

@interface QuickDialogController (Animations)

- (void)switchElementsWithAnimation:(UITableViewRowAnimation)animation elements:(NSArray *)elements;

- (void) hideElementsWithAnimation:(UITableViewRowAnimation)animation elements:(NSArray*)elements;
- (void) hideSectionsWithAnimation:(UITableViewRowAnimation)animation sections:(NSArray*)sections;
- (void) showElementsWithAnimation:(UITableViewRowAnimation)animation elements:(NSArray*)elements;
- (void) showSectionsWithAnimation:(UITableViewRowAnimation)animation sections:(NSArray*)sections;

- (void) showHideElementsWithInsertAnimation:(UITableViewRowAnimation)insertAnimation removeAnimation:(UITableViewRowAnimation)removeAnimation elementsToInsert:(NSArray*)ins elementsToRemove:(NSArray*) del;
- (void) showHideSectionsWithInsertAnimation:(UITableViewRowAnimation)insertAnimation removeAnimation:(UITableViewRowAnimation)removeAnimation sectionsToInsert:(NSArray*)ins sectionsToRemove:(NSArray*)del;

@end
