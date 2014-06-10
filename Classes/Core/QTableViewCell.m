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

static const int QCellMarginDouble = 16;
static const int QCellMargin = 8;
static const int QCellMinimumLabelWidth = 80;

@implementation QTableViewCell


- (instancetype)initWithReuseIdentifier:(NSString *)string {
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:string];
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    CGSize sizeWithMargin = self.bounds.size;

    if (self.imageView.image!=nil){
        sizeWithMargin = CGSizeMake(sizeWithMargin.width - self.imageView.image.size.width - QCellMarginDouble, sizeWithMargin.height);
    }

    self.detailTextLabel.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
    self.textLabel.backgroundColor = [[UIColor yellowColor] colorWithAlphaComponent:0.5];

    if (_labelingPolicy == QLabelingPolicyTrimTitle)
    {
        if (self.textLabel.text!=nil){
            sizeWithMargin = CGSizeMake(sizeWithMargin.width - QCellMinimumLabelWidth, sizeWithMargin.height- QCellMarginDouble);
        }

        CGSize detailsSize = CGSizeZero;
        if (self.detailTextLabel.text!=nil) {
            detailsSize = [self.detailTextLabel.text boundingRectWithSize:sizeWithMargin options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.detailTextLabel.font} context:nil].size;
        }

        self.detailTextLabel.frame = CGRectMake(
                self.bounds.size.width - detailsSize.width - QCellMargin,
                QCellMargin,
                detailsSize.width,
                self.bounds.size.height- QCellMarginDouble);

        self.textLabel.frame = CGRectMake(
                self.textLabel.frame.origin.x,
                QCellMargin,
                sizeWithMargin.width - detailsSize.width + QCellMinimumLabelWidth - QCellMarginDouble - QCellMarginDouble,
                self.bounds.size.height- QCellMarginDouble);

    } else {

        if (self.detailTextLabel.text!=nil){
            sizeWithMargin = CGSizeMake(sizeWithMargin.width- QCellMinimumLabelWidth, sizeWithMargin.height- QCellMarginDouble);
        }

        CGSize textWidth = CGSizeZero;
        if (!self.detailTextLabel.text) {
            textWidth = CGSizeMake(sizeWithMargin.width - QCellMarginDouble - QCellMargin, sizeWithMargin.height);
        } else if (self.textLabel.text!=nil) {
            textWidth = [self.textLabel.text boundingRectWithSize:sizeWithMargin options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.textLabel.font} context:nil].size;
        }

        self.textLabel.frame = CGRectMake(
                self.textLabel.frame.origin.x,
                QCellMargin,
                textWidth.width,
                self.bounds.size.height- QCellMarginDouble);

        CGFloat detailsWidth = self.bounds.size.width - self.textLabel.frame.origin.x - textWidth.width - QCellMargin;
        self.detailTextLabel.frame = CGRectMake(
                self.bounds.size.width - detailsWidth,
                QCellMargin,
                detailsWidth - (self.accessoryView ==nil ? 0 : QCellMargin) - (self.accessoryType !=UITableViewCellAccessoryNone ? 0 : QCellMargin),
                self.bounds.size.height- QCellMarginDouble);
    }
}


- (void)prepareForReuse
{
    [super prepareForReuse];
    self.currentElement.currentCell = nil;
    self.currentElement = nil;

    self.textLabel.text = nil;
    self.detailTextLabel.text = nil;
    self.imageView.image = nil;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.showsReorderControl = YES;
    self.accessoryView = nil;
    self.labelingPolicy = _labelingPolicy;


}

- (void)applyAppearanceForElement:(QElement *)element {
    QAppearance *appearance = element.appearance;
    self.textLabel.textColor = element.enabled  ? appearance.labelColorEnabled : appearance.labelColorDisabled;
    self.textLabel.font = appearance.titleFont;
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
