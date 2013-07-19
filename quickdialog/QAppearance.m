
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
    if (self.sectionTitleFont!=nil && tableView.style == UITableViewStyleGrouped){
        UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
        containerView.tag = 98989;
        containerView.backgroundColor = [UIColor clearColor];
        containerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;

        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, tableView.frame.size.width-40, [tableView.delegate tableView:tableView heightForHeaderInSection:index])];
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        label.text = section.title;
        [containerView addSubview:label];
        label.backgroundColor = [UIColor clearColor];
        label.font = self.sectionTitleFont;
        label.numberOfLines = 0;
        label.shadowColor = self.sectionTitleShadowColor;
        label.shadowOffset = CGSizeMake(0, 1);
        label.textColor = self.sectionTitleColor;
        return containerView;
    }
    return nil;
}

- (UIView *)buildFooterForSection:(QSection *)section andTableView:(QuickDialogTableView *)tableView andIndex:(NSInteger)index {
    if (self.sectionFooterFont!=nil && tableView.style == UITableViewStyleGrouped){
        CGSize textSize = [section.footer sizeWithFont:self.sectionFooterFont constrainedToSize:CGSizeMake(tableView.frame.size.width-40, 1000000)];
        UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, textSize.height+8)];
        containerView.tag = 89898;
        containerView.backgroundColor = [UIColor clearColor];
        containerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;

        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, tableView.frame.size.width-40, textSize.height)];
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        label.text = section.footer;
        label.textAlignment = NSTextAlignmentCenter;
        [containerView addSubview:label];
        label.backgroundColor = [UIColor clearColor];
        label.font = self.sectionFooterFont;
        label.textColor = self.sectionFooterColor;
        label.numberOfLines = 0;
        label.shadowColor = [UIColor colorWithWhite:1.0 alpha:1];
        label.shadowOffset = CGSizeMake(0, 1);

        section.footerView = containerView;
    }
    return nil;
}

- (CGFloat)heightForHeaderInSection:(QSection *)section andTableView:(QuickDialogTableView *)tableView andIndex:(NSInteger)index {

    if (section.headerView!=nil)
        return section.headerView.frame.size.height;

    if (section.title==nil)
        return 0;

    if (!tableView.root.grouped)  {

        return section.footer == NULL
                ? -1
                : [section.title sizeWithFont:self.sectionTitleFont constrainedToSize:CGSizeMake(tableView.frame.size.width-40, 1000000)].height+22;
    }

    CGFloat stringTitleHeight = 0;

    if (section.title != nil) {
        CGFloat maxWidth = tableView.bounds.size.width - 20;
        CGFloat maxHeight = 9999;
        CGSize maximumLabelSize = CGSizeMake(maxWidth,maxHeight);
        QAppearance *appearance = ((QuickDialogTableView *)tableView).root.appearance;
        CGSize expectedLabelSize = [section.title sizeWithFont:appearance==nil? [UIFont systemFontOfSize:[UIFont labelFontSize]] : appearance.sectionTitleFont
                                             constrainedToSize:maximumLabelSize
                                                 lineBreakMode:NSLineBreakByWordWrapping];

        stringTitleHeight = expectedLabelSize.height+23.f;
    }


    return section.title != NULL? stringTitleHeight : 0;
}

- (CGFloat)heightForFooterInSection:(QSection *)section andTableView:(QuickDialogTableView *)tableView andIndex:(NSInteger)index {

    if (section.footerView==nil && tableView.styleProvider!=nil && [tableView.styleProvider respondsToSelector:@selector(sectionFooterWillAppearForSection:atIndex:)]){
        [tableView.styleProvider sectionFooterWillAppearForSection:section atIndex:index];
    }

    if (section.footerView!=nil)
        return section.footerView.frame.size.height;

    QAppearance *appearance = tableView.root.appearance;

    return section.footer == NULL
            ? -1
            : [section.footer sizeWithFont:appearance.sectionFooterFont constrainedToSize:CGSizeMake(tableView.frame.size.width-40, 1000000)].height+22;
}
@end
