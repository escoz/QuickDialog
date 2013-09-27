//
//  QTableViewCellWithSubtitle.m
//  QuickDialog
//
//  Created by Hugo Doria on 9/27/13.
//
//

#import "QTableViewCellWithSubtitle.h"

@implementation QTableViewCellWithSubtitle

static const int kCellMarginDouble = 16;
static const int kCellMargin = 8;
static const int kCellMinimumLabelWidth = 40;
static const int kCellSubtitleYPosition = 20;

@synthesize labelingPolicy = _labelingPolicy;

- (QTableViewCell *)initWithReuseIdentifier:(NSString *)string
{
    self.subtitle = [UILabel new];
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:string];
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    CGSize imageSize = CGSizeZero;
    if (self.imageView!=nil)
        imageSize = self.imageView.frame.size;
    
    CGSize sizeWithMargin = self.contentView.bounds.size;
    
    if (_labelingPolicy == QLabelingPolicyTrimTitle)
    {
        if (self.textLabel.text!=nil){
            sizeWithMargin = CGSizeMake(sizeWithMargin.width-kCellMinimumLabelWidth, sizeWithMargin.height-kCellMarginDouble);
        }
        

        CGSize valueSize = CGSizeZero;
        if (self.detailTextLabel.text!=nil) {
            valueSize = [self.detailTextLabel.text sizeWithFont:self.detailTextLabel.font constrainedToSize:sizeWithMargin];
        }
        
        self.textLabel.frame = CGRectMake(
                                          self.textLabel.frame.origin.x,
                                          kCellMargin,
                                          self.contentView.bounds.size.width - valueSize.width - imageSize.width - kCellMarginDouble - kCellMarginDouble,
                                          self.contentView.bounds.size.height- kCellMarginDouble);
        
        self.detailTextLabel.frame = CGRectMake(
                                                self.contentView.bounds.size.width - valueSize.width - kCellMargin,
                                                kCellMargin,
                                                valueSize.width,
                                                self.contentView.bounds.size.height- kCellMarginDouble);
    } else {
        
        if (self.detailTextLabel.text!=nil){
            sizeWithMargin = CGSizeMake(sizeWithMargin.width-kCellMinimumLabelWidth, sizeWithMargin.height-kCellMarginDouble);
        }
        
        CGSize valueSize = CGSizeZero;
        if (!self.detailTextLabel.text) {
            valueSize = sizeWithMargin;
        } else if (self.textLabel.text!=nil) {
            valueSize = [self.textLabel.text sizeWithFont:self.textLabel.font constrainedToSize:sizeWithMargin];
        }
        
        self.textLabel.frame = CGRectMake(
                                          self.textLabel.frame.origin.x,
                                          0,
                                          valueSize.width,
                                          self.contentView.bounds.size.height- kCellMarginDouble);
       
 
        self.subtitle.frame = CGRectMake(
                                         self.textLabel.frame.origin.x,
                                         kCellSubtitleYPosition,
                                         self.contentView.bounds.size.width - kCellMarginDouble,
                                         self.contentView.bounds.size.height- kCellMarginDouble);
        
        CGFloat detailsWidth = self.contentView.bounds.size.width - imageSize.width - kCellMarginDouble;
        if (valueSize.width>0)
            detailsWidth = detailsWidth - valueSize.width - kCellMarginDouble;
        
        self.detailTextLabel.frame = CGRectMake(
                                                self.contentView.bounds.size.width - detailsWidth - kCellMargin,
                                                kCellMargin,
                                                detailsWidth - 5,
                                                self.contentView.bounds.size.height- kCellMarginDouble);
        
        [self.contentView addSubview:self.subtitle];
    }
}


- (void)applyAppearanceForElement:(QElement *)element
{
    QAppearance *appearance = element.appearance;
    
    self.textLabel.textColor = element.enabled  ? appearance.labelColorEnabled : appearance.labelColorDisabled;
    self.textLabel.font = appearance.labelFont;
    self.textLabel.textAlignment = appearance.labelAlignment;
    self.textLabel.numberOfLines = 0;
    self.textLabel.backgroundColor = [UIColor clearColor];
    
    self.subtitle.textColor = element.enabled  ? appearance.labelColorEnabled : appearance.labelColorDisabled;
    self.subtitle.font = appearance.labelFont;
    self.subtitle.textAlignment = appearance.labelAlignment;
    self.subtitle.numberOfLines = 1;
    self.subtitle.backgroundColor = [UIColor clearColor];
    
    self.detailTextLabel.textColor = element.enabled ? appearance.valueColorEnabled : appearance.valueColorDisabled;
    self.detailTextLabel.font = appearance.valueFont;
    self.detailTextLabel.textAlignment = appearance.valueAlignment;
    self.detailTextLabel.numberOfLines = 0;
    self.detailTextLabel.backgroundColor = [UIColor clearColor];
    
    self.backgroundColor = element.enabled ? appearance.backgroundColorEnabled : appearance.backgroundColorDisabled;
    self.selectedBackgroundView = element.appearance.selectedBackgroundView;
}

@end
