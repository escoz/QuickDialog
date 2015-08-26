#import <Foundation/Foundation.h>
#import "QElement.h"

@class QAppearance;

@interface QElement (Appearance)

@property(nonatomic, retain) QAppearance *appearance;

+ (QAppearance *)appearance;
+ (void)setAppearance:(QAppearance *)newAppearance;


@end
