#import "QuickDialogController+Animations.h"
#import "QuickDialog.h"

@implementation QuickDialogController (Animations)



- (void) hideElementsWithAnimation:(UITableViewRowAnimation)animation elements:(QElement*)element,...
{
    va_list args;
    va_start(args, element);
    [self hideElementsWithInsertAnimation:animation removeAnimation:animation elements:element args:args];
    va_end(args);
}
- (void) hideSectionsWithAnimation:(UITableViewRowAnimation)animation sections:(QSection*)section,...
{
    va_list args;
    va_start(args, section);
    [self hideSectionsWithInsertAnimation:animation removeAnimation:animation sections:section args:args];
    va_end(args);
}
- (void) hideElementsWithInsertAnimation:(UITableViewRowAnimation)insertAnimation removeAnimation:(UITableViewRowAnimation)removeAnimation elements:(QElement*)element,...
{
    va_list args;
    va_start(args, element);
    [self hideElementsWithInsertAnimation:insertAnimation removeAnimation:removeAnimation elements:element args:args];
    va_end(args);
}
- (void) hideSectionsWithInsertAnimation:(UITableViewRowAnimation)insertAnimation removeAnimation:(UITableViewRowAnimation)removeAnimation sections:(QSection*)section,...
{
    va_list args;
    va_start(args, section);
    [self hideSectionsWithInsertAnimation:insertAnimation removeAnimation:removeAnimation sections:section args:args];
    va_end(args);
}

- (void) hideElementsWithInsertAnimation:(UITableViewRowAnimation)insertAnimation removeAnimation:(UITableViewRowAnimation)removeAnimation elements:(QElement*)element args:(va_list)args
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

- (void) hideSectionsWithInsertAnimation:(UITableViewRowAnimation)insertAnimation removeAnimation:(UITableViewRowAnimation)removeAnimation sections:(QSection *)section args:(va_list)args
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



@end
