//
// Created by Eduardo Scoz on 7/18/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "QClassicAppearance.h"


@implementation QClassicAppearance {

}

- (void)setDefaults {
    [super setDefaults];

    self.labelColorDisabled = [UIColor lightGrayColor];
    self.labelColorEnabled = [UIColor blackColor];

    self.actionColorDisabled = [UIColor lightGrayColor];
    self.actionColorEnabled = [UIColor blackColor];

    self.sectionTitleFont = nil;
    self.sectionTitleShadowColor = [UIColor colorWithWhite:1.0 alpha:1];
    self.sectionTitleColor = [UIColor colorWithRed:0.298039 green:0.337255 blue:0.423529 alpha:1.000];

    self.sectionFooterFont = nil;
    self.sectionFooterColor = [UIColor colorWithRed:0.298039 green:0.337255 blue:0.423529 alpha:1.000];

    self.labelFont = [UIFont boldSystemFontOfSize:15];
    self.labelAlignment = NSTextAlignmentLeft;

    self.backgroundColorDisabled = [UIColor colorWithWhite:0.9605 alpha:1.0000];
    self.backgroundColorEnabled = [UIColor whiteColor];

    self.entryTextColorDisabled = [UIColor lightGrayColor];
    self.entryTextColorEnabled = [UIColor blackColor];
    self.entryAlignment = NSTextAlignmentLeft;
    self.entryFont = [UIFont systemFontOfSize:15];

    self.buttonAlignment = NSTextAlignmentCenter;

    self.valueColorEnabled = [UIColor colorWithRed:0.1653 green:0.2532 blue:0.4543 alpha:1.0000];
    self.valueColorDisabled = [UIColor lightGrayColor];
    self.valueFont = [UIFont systemFontOfSize:15];
    self.valueAlignment = NSTextAlignmentRight;

    self.toolbarStyle = UIBarStyleBlack;
    self.toolbarTranslucent = YES;
}

@end