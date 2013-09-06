
@implementation QAppearance {

}

@synthesize sectionTitleFont = _sectionTitleFont;
@synthesize sectionTitleColor = _sectionTitleColor;
@synthesize sectionFooterFont = _sectionFooterFont;
@synthesize sectionFooterColor = _sectionFooterColor;
@synthesize entryAlignment = _entryAlignment;
@synthesize buttonAlignment = _buttonAlignment;
@synthesize selectedBackgroundView = _selectedBackgroundView;
@synthesize sectionTitleShadowColor = _sectionTitleShadowColor;


- (QAppearance *)init {
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

        copy.labelFont = _labelFont;
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
    return UITableViewAutomaticDimension;
}

- (CGFloat)heightForFooterInSection:(QSection *)section andTableView:(QuickDialogTableView *)tableView andIndex:(NSInteger)index {
    if (section.footerView!=nil)
        return section.footerView.frame.size.height;

    return UITableViewAutomaticDimension;
}

- (void)cell:(UITableViewCell *)cell willAppearForElement:(QElement *)element atIndexPath:(NSIndexPath *)path {

}
@end
