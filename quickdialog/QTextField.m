//
// Created by hivehicks on 5/23/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "QTextField.h"


@implementation QTextField

@synthesize prefix = _prefix;
@synthesize suffix = _suffix;

- (void)drawTextInRect:(CGRect)rect
{
    if (_prefix || _suffix) {
        NSString *textWithSuffix = [NSString stringWithFormat:@"%@%@%@", _prefix ? _prefix : @"", self.text, _suffix ? _suffix : @""];
        CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(), self.textColor.CGColor);
        [textWithSuffix drawInRect:rect withFont:self.font lineBreakMode:UILineBreakModeTailTruncation alignment:self.textAlignment];
    } else {
        [super drawTextInRect:rect];
    }
}

@end