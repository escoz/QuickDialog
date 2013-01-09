#import <Foundation/Foundation.h>


@interface QAppearance : NSDictionary
- (id)initWithObjects:(id[])objects forKeys:(id[])keys count:(NSUInteger)cnt;

- (NSUInteger)count;

- (id)objectForKey:(id)aKey;


- (void)setObject:(NSString *)string forKey:(NSString *)key;
@end
