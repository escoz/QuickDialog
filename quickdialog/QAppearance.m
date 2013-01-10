
@implementation QAppearance {

}

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
    _labelFont = [UIFont boldSystemFontOfSize:15];
    _labelAlignment = NSTextAlignmentLeft;

    _backgroundColorDisabled = [UIColor colorWithWhite:0.9605 alpha:1.0000];
    _backgroundColorEnabled = [UIColor whiteColor];

    _tableSeparatorColor = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0];

    _entryTextColorDisabled = [UIColor lightGrayColor];
    _entryTextColorEnabled = [UIColor blackColor];
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
        copy.labelFont = _labelFont;
        copy.labelAlignment = _labelAlignment;

        copy.backgroundColorDisabled = _backgroundColorDisabled;
        copy.backgroundColorEnabled = _backgroundColorEnabled;

        copy.tableSeparatorColor = _tableSeparatorColor;

        copy.entryTextColorDisabled = _entryTextColorDisabled;
        copy.entryTextColorEnabled = _entryTextColorEnabled;
        copy.entryFont = _entryFont;

        copy.valueColorEnabled = _valueColorEnabled;
        copy.valueColorDisabled = _valueColorDisabled;
        copy.valueFont = _valueFont;
        copy.valueAlignment = _valueAlignment;
    }
    return copy;
}

@end
