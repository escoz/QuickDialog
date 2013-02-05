#import <Foundation/Foundation.h>


@interface QAppearance : NSObject<NSCopying>

@property(nonatomic, strong) UIColor *labelColorDisabled;
@property (nonatomic,strong) UIColor *labelColorEnabled;
@property (nonatomic,strong) UIFont *labelFont;
@property (nonatomic,strong)UIColor * backgroundColorEnabled;
@property (nonatomic,strong)UIColor * backgroundColorDisabled;
@property (nonatomic) NSTextAlignment labelAlignment;

@property (nonatomic,strong)UIColor *tableGroupedBackgroundColor;
@property (nonatomic,strong)UIColor *tableBackgroundColor;
@property (nonatomic,strong)UIView *tableBackgroundView;
@property (nonatomic,strong)UIColor *tableSeparatorColor;
@property (nonatomic,strong)UIFont *entryFont;
@property (nonatomic,strong)UIColor *entryTextColorEnabled;
@property (nonatomic,strong)UIColor *entryTextColorDisabled;
@property (nonatomic,strong)UIColor *valueColorEnabled;
@property (nonatomic,strong)UIColor *valueColorDisabled;
@property (nonatomic,strong)UIFont *valueFont;
@property (nonatomic) NSTextAlignment valueAlignment;
@property(nonatomic, strong) UIColor *actionColorEnabled;
@property(nonatomic, strong) UIColor * actionColorDisabled;
@property(nonatomic, strong) UIFont *sectionTitleFont;
@property(nonatomic, strong) UIColor *sectionTitleColor;
@property(nonatomic, strong) UIFont *sectionFooterFont;
@property(nonatomic, strong) UIColor *sectionFooterColor;
@property(nonatomic) NSTextAlignment entryAlignment;
@property(nonatomic, strong) UIView *selectedBackgroundView;
@property(nonatomic, strong) UIColor *sectionTitleShadowColor;
@end
