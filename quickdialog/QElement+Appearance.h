#import <Foundation/Foundation.h>

@interface QElement (Appearance)

@property(nonatomic, retain) NSMutableDictionary *appearance;

+ (NSMutableDictionary *)appearance;
+ (void)setAppearance:(NSMutableDictionary *)newAppearance;


@end
