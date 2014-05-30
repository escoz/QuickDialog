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

#import "QAppearance.h"
#import "QSection.h"
#import "QElement.h"

@implementation QAppearance {

}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setDefaults];
    }
    return self;
}


- (void)setDefaults {
}

- (id)copyWithZone:(NSZone *)zone {
    QAppearance *copy = [[[self class] allocWithZone:zone] init];
    if (copy != nil) {
        copy.labelColorDisabled = _labelColorDisabled;
        copy.labelColorEnabled = _labelColorEnabled;

        copy.actionColorDisabled = _actionColorDisabled;
        copy.actionColorEnabled = _actionColorEnabled;

        copy.titleFont = _titleFont;
        copy.labelAlignment = _labelAlignment;

        copy.backgroundColorDisabled = _backgroundColorDisabled;
        copy.backgroundColorEnabled = _backgroundColorEnabled;

        copy.tableSeparatorColor = _tableSeparatorColor;

        copy.entryTextColorDisabled = _entryTextColorDisabled;
        copy.entryTextColorEnabled = _entryTextColorEnabled;
        copy.entryAlignment = _entryAlignment;
        copy.entryFont = _entryFont;

        copy.buttonAlignment = _buttonAlignment;

        copy.valueColorEnabled = _valueColorEnabled;
        copy.valueColorDisabled = _valueColorDisabled;
        copy.valueFont = _valueFont;
        copy.valueAlignment = _valueAlignment;

        copy.tableBackgroundColor = _tableBackgroundColor;
        copy.tableGroupedBackgroundColor = _tableGroupedBackgroundColor;

        copy.sectionTitleColor = _sectionTitleColor;
        copy.sectionTitleShadowColor = _sectionTitleShadowColor;
        copy.sectionTitleFont = _sectionTitleFont;
        copy.sectionFooterColor = _sectionFooterColor;
        copy.sectionFooterFont = _sectionFooterFont;
    }
    return copy;
}

- (UIView *)buildHeaderForSection:(QSection *)section andTableView:(QuickDialogTableView *)tableView andIndex:(NSInteger)index{
    return nil;
}

- (UIView *)buildFooterForSection:(QSection *)section andTableView:(QuickDialogTableView *)tableView andIndex:(NSInteger)index {
    return nil;
}

- (CGFloat)heightForHeaderInSection:(QSection *)section andTableView:(QuickDialogTableView *)tableView andIndex:(NSInteger)index {
    if (section.headerView!=nil)
        return section.headerView.frame.size.height;
    if (self.defaultHeightForHeader!=nil)
        return self.defaultHeightForHeader.floatValue;
    return UITableViewAutomaticDimension;
}

- (CGFloat)heightForFooterInSection:(QSection *)section andTableView:(QuickDialogTableView *)tableView andIndex:(NSInteger)index {
    if (section.footerView!=nil)
        return section.footerView.frame.size.height;
    if (self.defaultHeightForFooter!=nil)
        return self.defaultHeightForFooter.floatValue;

    return UITableViewAutomaticDimension;
}

- (void)cell:(UITableViewCell *)cell willAppearForElement:(QElement *)element atIndexPath:(NSIndexPath *)path {

}
@end
