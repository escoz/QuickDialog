//
//  QFloatTableViewCell.m
//  QuickDialog
//
//  Created by Bart Vandendriessche on 29/04/13.
//
//

#import "QFloatTableViewCell.h"

@interface QFloatTableViewCell ()

@property (nonatomic, strong, readwrite) UISlider *slider;

@end

@implementation QFloatTableViewCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithReuseIdentifier:@"QFloatTableViewCell"];
    if (self) {
        self.slider = [[UISlider alloc] initWithFrame:CGRectZero];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.slider];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.textLabel.frame = CGRectMake(self.textLabel.frame.origin.x, self.textLabel.frame.origin.y, [self.textLabel.text sizeWithFont:self.textLabel.font].width, self.textLabel.frame.size.height);
    
    CGFloat width = self.textLabel.frame.origin.x + self.textLabel.frame.size.width;

    CGRect remainder, slice;
    CGRectDivide(self.contentView.bounds, &slice, &remainder, width, CGRectMinXEdge);
    CGFloat standardiOSMargin = 10;
    self.slider.frame = CGRectInset(remainder, standardiOSMargin, 0);
}

@end
