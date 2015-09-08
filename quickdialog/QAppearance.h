#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "QuickDialogTableView.h"


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
@property(nonatomic) NSTextAlignment buttonAlignment;
@property(nonatomic, strong) UIView *selectedBackgroundView;
@property(nonatomic, strong) UIColor *sectionTitleShadowColor;
@property(nonatomic) BOOL toolbarTranslucent;
@property(nonatomic) CGFloat cellBorderWidth;
@property(nonatomic) NSNumber * defaultHeightForHeader;
@property(nonatomic) NSNumber * defaultHeightForFooter;

@property(nonatomic) UIBarStyle toolbarStyle;


@property(nonatomic, strong) UIView *tableGroupedBackgroundView;

- (void)setDefaults;

- (UIView *)buildHeaderForSection:(QSection *)section andTableView:(QuickDialogTableView *)tableView andIndex:(NSInteger)index;

- (UIView *)buildFooterForSection:(QSection *)section andTableView:(QuickDialogTableView *)tableView andIndex:(NSInteger)index;

- (CGFloat)heightForHeaderInSection:(QSection *)section andTableView:(QuickDialogTableView *)tableView andIndex:(NSInteger)index;

- (CGFloat)heightForFooterInSection:(QSection *)section andTableView:(QuickDialogTableView *)tableView andIndex:(NSInteger)index;

- (void)cell:(UITableViewCell *)cell willAppearForElement:(QElement *)element atIndexPath:(NSIndexPath *)path;
@end
