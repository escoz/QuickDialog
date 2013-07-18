#import "QuickDialogController+Animations.h"
#import "QuickDialog.h"

@implementation QuickDialogController (Animations)



- (void) hideElementsWithAnimation:(UITableViewRowAnimation)animation element:(QElement*)element,...
{
    va_list args;
    va_start(args, element);
    [self hideElementsWithInsertAnimation:animation removeAnimation:animation element:element args:args];
    va_end(args);
}
- (void) hideSectionsWithAnimation:(UITableViewRowAnimation)animation section:(QSection*)section,...
{
    va_list args;
    va_start(args, section);
    [self hideSectionsWithInsertAnimation:animation removeAnimation:animation section:section args:args];
    va_end(args);
}
- (void) hideElementsWithInsertAnimation:(UITableViewRowAnimation)insertAnimation removeAnimation:(UITableViewRowAnimation)removeAnimation element:(QElement*)element,...
{
    va_list args;
    va_start(args, element);
    [self hideElementsWithInsertAnimation:insertAnimation removeAnimation:removeAnimation element:element args:args];
    va_end(args);
}
- (void) hideSectionsWithInsertAnimation:(UITableViewRowAnimation)insertAnimation removeAnimation:(UITableViewRowAnimation)removeAnimation section:(QSection*)section,...
{
    va_list args;
    va_start(args, section);
    [self hideSectionsWithInsertAnimation:insertAnimation removeAnimation:removeAnimation section:section args:args];
    va_end(args);
}

- (void) hideElementsWithInsertAnimation:(UITableViewRowAnimation)insertAnimation removeAnimation:(UITableViewRowAnimation)removeAnimation element:(QElement*)element args:(va_list)args
{
    NSMutableArray * idx = [NSMutableArray new];
    NSMutableArray * del = [NSMutableArray new];
    NSMutableArray * ins = [NSMutableArray new];

    while (element)
    {
        BOOL h = va_arg(args, /*BOOL*/int);
        if (h)
            [del addObject:element];
        else
            [ins addObject:element];
        element = va_arg(args, QElement*);
    }

    [self.quickDialogTableView beginUpdates];
    NSEnumerator * i = [del reverseObjectEnumerator];
    while ((element =/*=*/ i.nextObject))
    {
        if (!element.hidden)
        {
            [idx addObject:[NSIndexPath indexPathForRow:element.visibleIndex inSection:element.parentSection.visibleIndex]];
            element.hidden = YES;
        }
    }
    [self.quickDialogTableView deleteRowsAtIndexPaths:idx withRowAnimation:removeAnimation];

    [idx removeAllObjects];
    for (element in ins)
    {
        if (element.hidden)
        {
            element.hidden = NO;
            [idx addObject:[NSIndexPath indexPathForRow:element.visibleIndex inSection:element.parentSection.visibleIndex]];
        }
    }
    [self.quickDialogTableView insertRowsAtIndexPaths:idx withRowAnimation:insertAnimation];
    [self.quickDialogTableView endUpdates];
}

- (void) hideSectionsWithInsertAnimation:(UITableViewRowAnimation)insertAnimation removeAnimation:(UITableViewRowAnimation)removeAnimation section:(QSection *)section args:(va_list)args
{
    NSMutableIndexSet * idx = [NSMutableIndexSet new];
    NSMutableArray * del = [NSMutableArray new];
    NSMutableArray * ins = [NSMutableArray new];
    while (section)
    {
        BOOL h = va_arg(args, /*BOOL*/int);
        if (h)
            [del addObject:section];
        else
            [ins addObject:section];
        section = va_arg(args, QSection*);
    }

    [self.quickDialogTableView beginUpdates];
    NSEnumerator * i = [del reverseObjectEnumerator];
    while ((section =/*=*/ i.nextObject))
    {
        if (!section.hidden)
        {
            [idx addIndex:section.visibleIndex];
            section.hidden = YES;
        }
    }
    [self.quickDialogTableView deleteSections:idx withRowAnimation:removeAnimation];

    [idx removeAllIndexes];
    for (section in ins)
    {
        if (section.hidden)
        {
            section.hidden = NO;
            [idx addIndex:section.visibleIndex];
        }
    }
    [self.quickDialogTableView insertSections:idx withRowAnimation:insertAnimation];
    [self.quickDialogTableView endUpdates];
}

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
        }
    }
    [self.quickDialogTableView deleteRowsAtIndexPaths:idx withRowAnimation:removeAnimation];

    [idx removeAllObjects];
    for (QElement *element in ins)
    {
        if (element.hidden)
        {
            element.hidden = NO;
            [idx addObject:[NSIndexPath indexPathForRow:element.visibleIndex inSection:element.parentSection.visibleIndex]];
        }
    }
    [self.quickDialogTableView insertRowsAtIndexPaths:idx withRowAnimation:insertAnimation];
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
        }
    }
    [self.quickDialogTableView deleteSections:idx withRowAnimation:removeAnimation];

    [idx removeAllIndexes];
    for (QSection *section in ins)
    {
        if (section.hidden)
        {
            section.hidden = NO;
            [idx addIndex:section.visibleIndex];
        }
    }
    [self.quickDialogTableView insertSections:idx withRowAnimation:insertAnimation];
    [self.quickDialogTableView endUpdates];
}

@end
