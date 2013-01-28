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

@synthesize labelingPolicy = _labelingPolicy;

- (QTableViewCell *)initWithReuseIdentifier:(NSString *)string {
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:string];
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textLabel.backgroundColor = [UIColor clearColor];
    self.detailTextLabel.backgroundColor = [UIColor clearColor];

    if (_labelingPolicy == QLabelingPolicyTrimTitle)
    {
        CGSize imageSize = CGSizeZero;
            if (self.imageView!=nil)
                imageSize = self.imageView.frame.size;

        CGSize valueSize = CGSizeZero;
        if (self.detailTextLabel.text!=nil)
            valueSize = [self.detailTextLabel.text sizeWithFont:self.detailTextLabel.font];

        CGRect labelFrame = self.textLabel.frame;
        self.textLabel.frame = CGRectMake(labelFrame.origin.x, labelFrame.origin.y,
                self.contentView.bounds.size.width - valueSize.width - imageSize.width - 20, labelFrame.size.height);

        CGRect detailsFrame = self.detailTextLabel.frame;
        self.detailTextLabel.frame = CGRectMake(
                self.contentView.bounds.size.width - valueSize.width - 10,
                detailsFrame.origin.y, valueSize.width, detailsFrame.size.height);
    }
}


- (void)applyAppearanceForElement:(QElement *)element {
    QAppearance *appearance = element.appearance;
    self.textLabel.textColor = element.enabled  ? appearance.labelColorEnabled : appearance.labelColorDisabled;
    self.textLabel.font = appearance.labelFont;
    self.textLabel.textAlignment = appearance.labelAlignment;

    self.detailTextLabel.textColor = element.enabled ? appearance.valueColorEnabled : appearance.valueColorDisabled;
    self.detailTextLabel.font = appearance.valueFont;
    self.detailTextLabel.textAlignment = appearance.valueAlignment;

    self.backgroundColor = element.enabled ? appearance.backgroundColorEnabled : appearance.backgroundColorDisabled;
    self.selectedBackgroundView = element.appearance.selectedBackgroundView;

}
@end
