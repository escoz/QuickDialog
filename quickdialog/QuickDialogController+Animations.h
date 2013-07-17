#import <Foundation/Foundation.h>
#import "QuickDialogController.h"

@interface QuickDialogController (Animations)

- (void) hideElementsWithInsertAnimation:(UITableViewRowAnimation)insertAnimation removeAnimation:(UITableViewRowAnimation)removeAnimation element:(QElement*)element,... NS_REQUIRES_NIL_TERMINATION;
- (void) hideSectionsWithInsertAnimation:(UITableViewRowAnimation)insertAnimation removeAnimation:(UITableViewRowAnimation)removeAnimation section:(QSection*)section,... NS_REQUIRES_NIL_TERMINATION;

- (void) hideElementsWithAnimation:(UITableViewRowAnimation)animation elements:(QElement*)element,... NS_REQUIRES_NIL_TERMINATION;
- (void) hideSectionsWithAnimation:(UITableViewRowAnimation)animation sections:(QSection*)section,... NS_REQUIRES_NIL_TERMINATION;

- (void)switchElementsWithAnimation:(UITableViewRowAnimation)animation elements:(NSArray *)elements;

- (void) hideElementsWithAnimation:(UITableViewRowAnimation)animation elements:(NSArray*)elements;
- (void) hideSectionsWithAnimation:(UITableViewRowAnimation)animation sections:(NSArray*)sections;
- (void) showElementsWithAnimation:(UITableViewRowAnimation)animation elements:(NSArray*)elements;
- (void) showSectionsWithAnimation:(UITableViewRowAnimation)animation sections:(NSArray*)sections;

- (void) showHideElementsWithInsertAnimation:(UITableViewRowAnimation)insertAnimation removeAnimation:(UITableViewRowAnimation)removeAnimation elementsToInsert:(NSArray*)ins elementsToRemove:(NSArray*) del;
- (void) showHideSectionsWithInsertAnimation:(UITableViewRowAnimation)insertAnimation removeAnimation:(UITableViewRowAnimation)removeAnimation sectionsToInsert:(NSArray*)ins sectionsToRemove:(NSArray*)del;

@end
