//
//  Created by escoz on 1/6/12.
//
#import "QBadgeLabel.h"

@implementation QBadgeLabel {
    UIColor *_badgeColor;
}
@synthesize badgeColor = _badgeColor;

- (QBadgeLabel *)init {
    self = [super init];
    self.frame = CGRectMake(0, 0, 100, 20);
    self.textColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor clearColor];
    self.badgeColor = [UIColor colorWithRed:0.530f green:0.600f blue:0.738f alpha:1.000f];
    self.font = [UIFont boldSystemFontOfSize:14];
    self.textAlignment = UITextAlignmentCenter;
    self.clipsToBounds = NO;
    return self;
}

- (void)setFrame:(CGRect)aFrame {
    CGFloat radius = aFrame.size.height/3;
    CGRect newFrame = CGRectMake(aFrame.origin.x - radius, aFrame.origin.y, aFrame.size.width+radius*2, aFrame.size.height);
    [super setFrame:newFrame];
}


- (void) drawRect:(CGRect)rect
{
    [self sizeToFit];

	CGContextRef context = UIGraphicsGetCurrentContext();
	float radius = self.frame.size.height / 2.0f;

	CGContextSaveGState(context);
    CGContextSetFillColorWithColor(context, [_badgeColor CGColor]);
	CGContextBeginPath(context);
	CGContextAddArc(context, 0+radius, radius, radius, (CGFloat)M_PI_2 , 3.0f * (CGFloat)M_PI_2, NO);
	CGContextAddArc(context, 0 + self.frame.size.width-radius, radius, radius, 3.0f * (CGFloat)M_PI_2, (CGFloat)M_PI_2, NO);
	CGContextClosePath(context);
	CGContextFillPath(context);
	CGContextRestoreGState(context);

    [super drawRect:rect];
}


@end