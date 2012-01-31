#import <CoreGraphics/CoreGraphics.h>
#import "QTableViewCell.h"

@implementation QTableViewCell


- (QTableViewCell *)initWithReuseIdentifier:(NSString *)string {
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:string];
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGSize valueSize = CGSizeZero;
    if (self.detailTextLabel.text!=nil)
        valueSize = [self.detailTextLabel.text sizeWithFont:self.detailTextLabel.font];

    if (valueSize.width>0){
        const CGRect labelFrame = self.textLabel.frame;
        self.textLabel.frame = CGRectMake(labelFrame.origin.x, labelFrame.origin.y, self.bounds.size.width - valueSize.width - 40, labelFrame.size.height);
    
        const CGRect detailsFrame = self.detailTextLabel.frame;
        self.detailTextLabel.frame = CGRectMake(self.bounds.size.width-valueSize.width-30, detailsFrame.origin.y, valueSize.width, detailsFrame.size.height);
    }
}

@end