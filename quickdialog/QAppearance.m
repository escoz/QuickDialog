
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

}

- (id)copyWithZone:(NSZone *)zone {
    QAppearance *copy = [[[self class] allocWithZone:zone] init];
    if (copy != nil) {
    }
    return copy;
}

@end
