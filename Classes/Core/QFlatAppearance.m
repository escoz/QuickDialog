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

#import "QFlatAppearance.h"
#import "QSection.h"


@implementation QFlatAppearance {

}
- (void)setDefaults {
    [super setDefaults];

    self.labelColorDisabled = [UIColor lightGrayColor];
    self.labelColorEnabled = [UIColor blackColor];

    self.actionColorDisabled = [UIColor lightGrayColor];
    self.actionColorEnabled = [UIColor blackColor];

    self.sectionTitleFont = nil;
    self.sectionTitleShadowColor = [UIColor clearColor];
    self.sectionTitleColor = nil;

    self.sectionFooterFont = nil;
    self.sectionFooterColor = [UIColor colorWithRed:0.2417 green:0.5295 blue:0.9396 alpha:1.0000];

    self.labelAlignment = NSTextAlignmentLeft;

    self.backgroundColorDisabled = [UIColor whiteColor];
    self.backgroundColorEnabled = [UIColor whiteColor];

    self.entryTextColorDisabled = [UIColor lightGrayColor];
    self.entryTextColorEnabled = [UIColor colorWithRed:0.243 green:0.306 blue:0.435 alpha:1.0];
    self.entryAlignment = NSTextAlignmentLeft;

    self.buttonAlignment = NSTextAlignmentLeft;

    self.valueColorEnabled = [UIColor colorWithRed:0.1653 green:0.2532 blue:0.4543 alpha:1.0000];
    self.valueColorDisabled = [UIColor lightGrayColor];
    self.valueAlignment = NSTextAlignmentRight;

    self.toolbarStyle = UIBarStyleDefault;
    self.toolbarTranslucent = YES;

    self.valueFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.titleFont = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    self.entryFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    
}

- (UIView *)buildHeaderForSection:(QSection *)section andTableView:(QuickDialogTableView *)view andIndex:(NSInteger)index1 {
    return nil;
}

- (UIView *)buildFooterForSection:(QSection *)section andTableView:(QuickDialogTableView *)view andIndex:(NSInteger)index1 {
    return nil;
}

- (void)cell:(UITableViewCell *)cell willAppearForElement:(QElement *)element atIndexPath:(NSIndexPath *)path {
    [super cell:cell willAppearForElement:element atIndexPath:path];
}

- (CGFloat)heightForHeaderInSection:(QSection *)section andTableView:(QuickDialogTableView *)tableView andIndex:(NSInteger)index {
    if (section.headerView!=nil)
        return section.headerView.bounds.size.height;
    return [super heightForHeaderInSection:section andTableView:tableView andIndex:index];
}

@end
