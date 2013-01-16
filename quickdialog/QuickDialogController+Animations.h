#import <Foundation/Foundation.h>
#import "QuickDialogController.h"

@interface QuickDialogController (Animations)

- (void) hideElementsWithInsertAnimation:(UITableViewRowAnimation)insertAnimation removeAnimation:(UITableViewRowAnimation)removeAnimation elements:(QElement*)element,...;
- (void) hideSectionsWithInsertAnimation:(UITableViewRowAnimation)insertAnimation removeAnimation:(UITableViewRowAnimation)removeAnimation sections:(QSection*)section,...;

- (void) hideElementsWithAnimation:(UITableViewRowAnimation)animation elements:(QElement*)element,...;
- (void) hideSectionsWithAnimation:(UITableViewRowAnimation)animation sections:(QSection*)section,...;

@end
