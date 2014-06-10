//
//  QProgressElement.m
//
//  Created by Xhacker on 2013-04-12.
//

#import "QProgressElement.h"

@interface QProgressElement ()

@property UIProgressView *bar;

@end

@implementation QProgressElement

- (instancetype)init
{
    self = [super init];
    self.bar = [[UIProgressView alloc] init];
    return self;
}

- (void)setProgress:(float)progress
{
    _progress = progress;
    self.bar.progress = progress;
}

- (void)setCurrentCell:(UITableViewCell *)cell
{
    super.currentCell = cell;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    self.bar.frame = CGRectMake(0, 0, cell.contentView.frame.size.width - 60, self.bar.frame.size.height);
    self.bar.center = CGPointMake(cell.contentView.frame.size.width / 2, cell.contentView.frame.size.height / 2);
    self.bar.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    [cell.contentView addSubview:self.bar];
}

@end
