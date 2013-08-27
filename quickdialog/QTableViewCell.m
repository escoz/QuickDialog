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

#import "QTableViewCell.h"
@implementation QTableViewCell

static const int kCellMarginDouble = 16;
static const int kCellMargin = 8;
static const int kCellMinimumLabelWidth = 40;


@synthesize labelingPolicy = _labelingPolicy;

- (QTableViewCell *)initWithReuseIdentifier:(NSString *)string {
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
                kCellMargin,
                valueSize.width,
                self.contentView.bounds.size.height- kCellMarginDouble);

        CGFloat detailsWidth = self.contentView.bounds.size.width - imageSize.width - kCellMarginDouble;
        if (valueSize.width>0)
            detailsWidth = detailsWidth - valueSize.width - kCellMarginDouble;

        self.detailTextLabel.frame = CGRectMake(
                self.contentView.bounds.size.width - detailsWidth - kCellMargin,
                kCellMargin,
                detailsWidth,
                self.contentView.bounds.size.height- kCellMarginDouble);
    }
}


- (void)applyAppearanceForElement:(QElement *)element {
    QAppearance *appearance = element.appearance;
    self.textLabel.textColor = element.enabled  ? appearance.labelColorEnabled : appearance.labelColorDisabled;
    self.textLabel.font = appearance.labelFont;
    self.textLabel.textAlignment = appearance.labelAlignment;
    self.textLabel.numberOfLines = 0;
    self.textLabel.backgroundColor = [UIColor clearColor];

    self.detailTextLabel.textColor = element.enabled ? appearance.valueColorEnabled : appearance.valueColorDisabled;
    self.detailTextLabel.font = appearance.valueFont;
    self.detailTextLabel.textAlignment = appearance.valueAlignment;
    self.detailTextLabel.numberOfLines = 0;
    self.detailTextLabel.backgroundColor = [UIColor clearColor];

    self.backgroundColor = element.enabled ? appearance.backgroundColorEnabled : appearance.backgroundColorDisabled;
    self.selectedBackgroundView = element.appearance.selectedBackgroundView;

}
@end
