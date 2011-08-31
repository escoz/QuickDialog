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