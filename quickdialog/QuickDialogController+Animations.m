#import "QuickDialogController+Animations.h"
#import "QElement.h"
#import "QRootElement.h"

@implementation QuickDialogController (Animations)


- (void) switchElementsWithAnimation:(UITableViewRowAnimation)animation elements:(NSArray*)elements
{
    NSMutableArray *in= [NSMutableArray new];
    NSMutableArray *out = [NSMutableArray new];
    for (QElement *el in elements){
        if (el.hidden)
            [in addObject:el];
        else
            [out addObject:el];
    }
    [self showHideElementsWithInsertAnimation:animation removeAnimation:animation elementsToInsert:in elementsToRemove:out];

}
- (void) hideElementsWithAnimation:(UITableViewRowAnimation)animation elements:(NSArray*)elements
{
    [self showHideElementsWithInsertAnimation:animation removeAnimation:animation elementsToInsert:nil elementsToRemove:elements];
}
- (void) hideSectionsWithAnimation:(UITableViewRowAnimation)animation sections:(NSArray*)sections
{
    [self showHideSectionsWithInsertAnimation:animation removeAnimation:animation sectionsToInsert:nil sectionsToRemove:sections];
}
- (void) showElementsWithAnimation:(UITableViewRowAnimation)animation elements:(NSArray*)elements
{
    [self showHideElementsWithInsertAnimation:animation removeAnimation:animation elementsToInsert:elements elementsToRemove:nil];
}
- (void) showSectionsWithAnimation:(UITableViewRowAnimation)animation sections:(NSArray*)sections
{
    [self showHideSectionsWithInsertAnimation:animation removeAnimation:animation sectionsToInsert:sections sectionsToRemove:nil];
}

- (void) showHideElementsWithInsertAnimation:(UITableViewRowAnimation)insertAnimation removeAnimation:(UITableViewRowAnimation)removeAnimation elementsToInsert:(NSArray*)ins elementsToRemove:(NSArray*) del
{
    NSMutableArray * idx = [NSMutableArray new];

    [self.quickDialogTableView beginUpdates];
    for (QElement *element in [del reverseObjectEnumerator])
    {
        if (!element.hidden)
        {
            [idx addObject:[NSIndexPath indexPathForRow:element.visibleIndex inSection:element.parentSection.visibleIndex]];
            element.hidden = YES;
            [self.quickDialogTableView deleteRowsAtIndexPaths:idx withRowAnimation:removeAnimation];
        }
    }

    [idx removeAllObjects];
    for (QElement *element in ins)
    {
        if (element.hidden)
        {
            element.hidden = NO;
            [idx addObject:[NSIndexPath indexPathForRow:element.visibleIndex inSection:element.parentSection.visibleIndex]];
            [self.quickDialogTableView insertRowsAtIndexPaths:idx withRowAnimation:insertAnimation];
        }
    }
    [self.quickDialogTableView endUpdates];
}

- (void) showHideSectionsWithInsertAnimation:(UITableViewRowAnimation)insertAnimation removeAnimation:(UITableViewRowAnimation)removeAnimation sectionsToInsert:(NSArray*)ins sectionsToRemove:(NSArray*)del
{
    NSMutableIndexSet * idx = [NSMutableIndexSet new];

    [self.quickDialogTableView beginUpdates];
    for (QSection *section in [del reverseObjectEnumerator])
    {
        if (!section.hidden)
        {
            [idx addIndex:section.visibleIndex];
            section.hidden = YES;
            [self.quickDialogTableView deleteSections:idx withRowAnimation:removeAnimation];
        }
    }

    [idx removeAllIndexes];
    for (QSection *section in ins)
    {
        if (section.hidden)
        {
            section.hidden = NO;
            [idx addIndex:section.visibleIndex];
            [self.quickDialogTableView insertSections:idx withRowAnimation:insertAnimation];
        }
    }
    [self.quickDialogTableView endUpdates];
}

@end
