#import <Foundation/Foundation.h>

@interface NSMutableArray (MoveObject)

- (void)moveObjectFromIndex:(NSUInteger)from toIndex:(NSUInteger)to;

@end
