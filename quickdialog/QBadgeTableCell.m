//                                
// Copyright 2011 ESCOZ Inc  - http://escoz.com
// 
// Licensed under the Apache License, Version 2.0 (the "License"); you may not use this 
// file except in compliance with the License. You may obtain a copy of the License at 
// 
// http://www.apache.org/licenses/LICENSE-2.0 
// 
// Unless required by applicable law or agreed to in writing, software distributed under
// the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF 
// ANY KIND, either express or implied. See the License for the specific language governing
// permissions and limitations under the License.
//

#import "QBadgeTableCell.h"
#import "QBadgeLabel.h"

@interface QBadgeTableCell ()
@end

@implementation QBadgeTableCell

@synthesize badgeLabel = _badgeLabel;

- (QBadgeTableCell *)init {
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"QuickformBadgeElement"];
    if (self){
        _badgeLabel = [[QBadgeLabel alloc] init];
        [self.contentView addSubview:_badgeLabel];
        _badgeLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _badgeLabel.contentMode = UIViewContentModeRedraw;
        _badgeLabel.contentStretch = CGRectMake(1., 0., 0., 0.);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect rect = self.contentView.frame;
    CGSize badgeTextSize = [_badgeLabel.text sizeWithFont:_badgeLabel.font];
    _badgeLabel.frame = CGRectIntegral(CGRectMake(rect.size.width - badgeTextSize.width - 10, ((rect.size.height - badgeTextSize.height) / 2)+1, badgeTextSize.width, badgeTextSize.height));
    CGRect lblFrame = self.textLabel.frame;

    if ((badgeTextSize.width+40+lblFrame.size.width)>self.contentView.bounds.size.width) {
        CGFloat newWidth = lblFrame.size.width-badgeTextSize.width;
        self.textLabel.frame = CGRectMake(lblFrame.origin.x, lblFrame.origin.y, newWidth, lblFrame.size.height);
    }
}


@end