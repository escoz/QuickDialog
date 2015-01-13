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

- (QProgressElement *)init
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

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller
{
    QTableViewCell *const cell = [[QTableViewCell alloc] init];
    [cell applyAppearanceForElement:self];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.bar.frame = CGRectMake(0, 0, cell.contentView.frame.size.width - 60, self.bar.frame.size.height);
    self.bar.center = CGPointMake(cell.contentView.frame.size.width / 2, cell.contentView.frame.size.height / 2);
    self.bar.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    [cell.contentView addSubview:self.bar];
    return cell;
}

@end
