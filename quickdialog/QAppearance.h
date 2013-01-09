#import <Foundation/Foundation.h>


@interface QAppearance : NSObject<NSCopying>

@property(nonatomic, readonly) UIColor *labelColorDisabled;

@property (nonatomic,strong) UIColor *labelColorEnabled;
@property (nonatomic,strong) UIFont *labelFont;
@property (nonatomic,strong)UIColor * backgroundColorEnabled;
@property (nonatomic,strong)UIColor * backgroundColorDisabled;
@end
