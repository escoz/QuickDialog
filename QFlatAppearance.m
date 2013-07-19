//
// Created by Eduardo Scoz on 7/18/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "QFlatAppearance.h"


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

    self.labelFont = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline2];
    self.labelAlignment = NSTextAlignmentLeft;

    self.backgroundColorDisabled = [UIColor whiteColor];
    self.backgroundColorEnabled = [UIColor whiteColor];

    self.entryTextColorDisabled = [UIColor lightGrayColor];
    self.entryTextColorEnabled = [UIColor blackColor];
    self.entryAlignment = NSTextAlignmentLeft;
    self.entryFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];

    self.buttonAlignment = NSTextAlignmentLeft;

    self.valueColorEnabled = [UIColor colorWithRed:0.1653 green:0.2532 blue:0.4543 alpha:1.0000];
    self.valueColorDisabled = [UIColor lightGrayColor];
    self.valueFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.valueAlignment = NSTextAlignmentRight;

    self.toolbarStyle = UIBarStyleDefault;
    self.toolbarTranslucent = YES;
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


@end