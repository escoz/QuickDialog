#import "NSMutableArray+MoveObject.h"

@implementation NSMutableArray (MoveObject)

- (void)moveObjectFromIndex:(NSUInteger)from toIndex:(NSUInteger)to
{
    if (to == from)
        return;

    id objectToMove = [self objectAtIndex:from];
    [self removeObjectAtIndex:from];
    if (to >= [self count]) {
        [self addObject:objectToMove];
    } else {
        [self insertObject:objectToMove atIndex:to];
    }
}
@end

