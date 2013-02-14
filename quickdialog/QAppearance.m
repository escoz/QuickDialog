
@implementation QAppearance {

}
@synthesize sectionTitleFont = _sectionTitleFont;
@synthesize sectionTitleColor = _sectionTitleColor;
@synthesize sectionFooterFont = _sectionFooterFont;
@synthesize sectionFooterColor = _sectionFooterColor;
@synthesize entryAlignment = _entryAlignment;
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
    _labelColorDisabled = [UIColor lightGrayColor];
    _labelColorEnabled = [UIColor blackColor];

    _actionColorDisabled = [UIColor lightGrayColor];
    _actionColorEnabled = [UIColor blackColor];

    _sectionTitleFont = [UIFont boldSystemFontOfSize:17];
    _sectionTitleShadowColor = [UIColor colorWithWhite:1.0 alpha:1];
    _sectionTitleColor = [UIColor colorWithRed:0.298039 green:0.337255 blue:0.423529 alpha:1.000];

    _sectionFooterFont = [UIFont systemFontOfSize:15];
    _sectionFooterColor = [UIColor colorWithRed:0.298039 green:0.337255 blue:0.423529 alpha:1.000];

    _labelFont = [UIFont boldSystemFontOfSize:15];
    _labelAlignment = NSTextAlignmentLeft;

    _backgroundColorDisabled = [UIColor colorWithWhite:0.9605 alpha:1.0000];
    _backgroundColorEnabled = [UIColor whiteColor];

    _entryTextColorDisabled = [UIColor lightGrayColor];
    _entryTextColorEnabled = [UIColor blackColor];
    _entryAlignment = NSTextAlignmentLeft;
    _entryFont = [UIFont systemFontOfSize:15];

    _valueColorEnabled = [UIColor colorWithRed:0.1653 green:0.2532 blue:0.4543 alpha:1.0000];
    _valueColorDisabled = [UIColor lightGrayColor];
    _valueFont = [UIFont systemFontOfSize:15];
    _valueAlignment = NSTextAlignmentRight;
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

@end
