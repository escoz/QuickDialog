//
//  Created by escoz on 7/13/11.
//

#import "QBadgeTableCell.h"
#import <QuartzCore/QuartzCore.h>

@interface QBadgeTableCell ()
@end

@implementation QBadgeTableCell

@synthesize badgeColor = _badgeColor;
@synthesize badgeLabel = _badgeLabel;


- (QBadgeTableCell *)init {
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"QuickformBadgeElement"];
    if (self){
        _badgeColor = [UIColor colorWithRed:0.530f green:0.600f blue:0.738f alpha:1.000f];
        _badgeLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_badgeLabel];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _badgeLabel.backgroundColor = _badgeColor;
        _badgeLabel.textColor = [UIColor whiteColor];
        _badgeLabel.backgroundColor = [UIColor clearColor];
        _badgeLabel.textAlignment = UITextAlignmentCenter;
        _badgeLabel.font = [UIFont boldSystemFontOfSize:14];
    
    }
    return self;
}

- (void) drawRect:(CGRect)rect
{	
    [_badgeLabel sizeToFit];
    _badgeLabel.frame= CGRectMake(self.contentView.frame.size.width-_badgeLabel.frame.size.width-_badgeLabel.frame.size.height, 12, _badgeLabel.frame.size.width, _badgeLabel.frame.size.height);
    
	CGContextRef context = UIGraphicsGetCurrentContext();
	float radius = _badgeLabel.frame.size.height / 2.0f;
    
	CGContextSaveGState(context);
    CGContextSetFillColorWithColor(context, [_badgeColor CGColor]);
	CGContextBeginPath(context);
	CGContextAddArc(context, _badgeLabel.frame.origin.x , _badgeLabel.frame.origin.y + radius, radius, (CGFloat)M_PI_2 , 3.0f * (CGFloat)M_PI_2, NO);
	CGContextAddArc(context, _badgeLabel.frame.origin.x + _badgeLabel.frame.size.width, _badgeLabel.frame.origin.y + radius, radius, 3.0f * (CGFloat)M_PI_2, (CGFloat)M_PI_2, NO);
	CGContextClosePath(context);
	CGContextFillPath(context);
	CGContextRestoreGState(context);
}



@end