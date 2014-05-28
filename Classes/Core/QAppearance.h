//
// Copyright 2011 ESCOZ Inc  - http://escoz.com
//
// Licensed under the Apache License, Version 2.0 (the "License"); you may not use this
// file except in compliance with the License. You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software distributed under
// the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF
// ANY KIND, either express or implied. See the License for the specific language governing
// permissions and limitations under the License.
//

#import <Foundation/Foundation.h>

@class QSection;
@class QuickDialogTableView;
@class QElement;


@interface QAppearance : NSObject<NSCopying>

@property(nonatomic, strong) UIColor *labelColorDisabled;
@property (nonatomic,strong) UIColor *labelColorEnabled;
@property (nonatomic,strong) UIFont *titleFont;
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
