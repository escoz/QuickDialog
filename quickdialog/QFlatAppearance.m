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

    self.cellBorderWidth = 14;
    
#if __IPHONE_7_0
    self.valueFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.labelFont = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    self.entryFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
#endif
    
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