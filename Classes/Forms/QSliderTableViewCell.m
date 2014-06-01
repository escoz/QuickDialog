//
//  QSliderTableViewCell.m
//  QuickDialog
//
//  Created by Bart Vandendriessche on 29/04/13.
//
//

#import "QSliderTableViewCell.h"

@interface QSliderTableViewCell ()

@property (nonatomic, strong, readwrite) UISlider *slider;

@end

@implementation QSliderTableViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithReuseIdentifier:@"QSliderTableViewCell"];
    if (self) {
        self.slider = [[UISlider alloc] initWithFrame:CGRectZero];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.slider];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    self.slider.frame = self.detailTextLabel.frame;
}

@end
