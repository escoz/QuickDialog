#import <Foundation/Foundation.h>
#import "QuickDialogController.h"

@interface QuickDialogController (Animations)

- (void) hideElementsWithInsertAnimation:(UITableViewRowAnimation)insertAnimation removeAnimation:(UITableViewRowAnimation)removeAnimation elements:(QElement*)element,... NS_REQUIRES_NIL_TERMINATION;
- (void) hideSectionsWithInsertAnimation:(UITableViewRowAnimation)insertAnimation removeAnimation:(UITableViewRowAnimation)removeAnimation sections:(QSection*)section,... NS_REQUIRES_NIL_TERMINATION;

- (void) hideElementsWithAnimation:(UITableViewRowAnimation)animation elements:(QElement*)element,... NS_REQUIRES_NIL_TERMINATION;
- (void) hideSectionsWithAnimation:(UITableViewRowAnimation)animation sections:(QSection*)section,... NS_REQUIRES_NIL_TERMINATION;

@end
