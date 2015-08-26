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
#import "QAppearance.h"
#import "QElement+Appearance.h"

@implementation QTableViewCell

static const int kCellMinimumLabelWidth = 80;


@synthesize labelingPolicy = _labelingPolicy;

- (QTableViewCell *)initWithReuseIdentifier:(NSString *)string {
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:string];
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    [self layoutSubviewsInsideBounds:self.contentView.bounds];

}

- (void)layoutSubviewsInsideBounds:(CGRect)bounds
{
    CGSize sizeWithMargin = bounds.size;

    if (self.imageView.image!=nil){
        sizeWithMargin = CGSizeMake(sizeWithMargin.width - self.imageView.image.size.width - QCellMarginDouble, sizeWithMargin.height);
    }

    if (_labelingPolicy == QLabelingPolicyTrimTitle)
    {
        if (self.textLabel.text!=nil){
            sizeWithMargin = CGSizeMake(sizeWithMargin.width-kCellMinimumLabelWidth, sizeWithMargin.height- QCellMarginDouble);
        }

        CGSize valueSize = CGSizeZero;
        if (self.detailTextLabel.text!=nil) {
            valueSize = [self.detailTextLabel.text sizeWithFont:self.detailTextLabel.font constrainedToSize:sizeWithMargin];
        }

        self.textLabel.frame = CGRectMake(
                self.textLabel.frame.origin.x,
                QCellMargin,
                bounds.size.width - valueSize.width - QCellMarginDouble - QCellMarginDouble,
                bounds.size.height- QCellMarginDouble);

        self.detailTextLabel.frame = CGRectMake(
                bounds.size.width - valueSize.width - QCellMargin,
                QCellMargin,
                valueSize.width,
                bounds.size.height- QCellMarginDouble);
    } else {

        if (self.detailTextLabel.text!=nil){
            sizeWithMargin = CGSizeMake(sizeWithMargin.width-kCellMinimumLabelWidth, sizeWithMargin.height- QCellMarginDouble);
        }

        CGSize valueSize = CGSizeZero;
        if (!self.detailTextLabel.text) {
            valueSize = CGSizeMake(sizeWithMargin.width - QCellMarginDouble - QCellMargin, sizeWithMargin.height);
        } else if (self.textLabel.text!=nil) {
            valueSize = [self.textLabel.text sizeWithFont:self.textLabel.font constrainedToSize:sizeWithMargin];
        }

        self.textLabel.frame = CGRectMake(
                self.textLabel.frame.origin.x,
                QCellMargin,
                valueSize.width,
                bounds.size.height- QCellMarginDouble);

        CGFloat detailsWidth = bounds.size.width - QCellMarginDouble;
        if (valueSize.width>0)
            detailsWidth = detailsWidth - valueSize.width - QCellMarginDouble;

        self.detailTextLabel.frame = CGRectMake(
                bounds.size.width - detailsWidth ,
                QCellMargin,
                detailsWidth - (self.accessoryView ==nil ? 0 : QCellMarginDouble) - (self.accessoryType !=UITableViewCellAccessoryNone ? 0 : QCellMarginDouble),
                bounds.size.height- QCellMarginDouble);
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
