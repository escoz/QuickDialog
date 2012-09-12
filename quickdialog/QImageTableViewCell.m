//
// Copyright 2012 Ludovic Landry - http://about.me/ludoviclandry
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

@implementation QImageTableViewCell

@synthesize detailImageView = _detailImageView;

- (void)createSubviews {
   _detailImageView = [[UIImageView alloc] init];
   _detailImageView.contentMode = UIViewContentModeScaleAspectFill;
   _detailImageView.layer.cornerRadius = 4.0f;
   _detailImageView.layer.masksToBounds = YES;
   _detailImageView.contentMode = UIViewContentModeScaleAspectFill;
   _detailImageView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.3];
   _detailImageView.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
   [self.contentView addSubview:_detailImageView];
   [self setNeedsLayout];
}

- (QImageTableViewCell *)init {
   self = [self initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"QuickformImageElement"];
   if (self!=nil){
      self.selectionStyle = UITableViewCellSelectionStyleNone;
      
      [self createSubviews];
   }
   return self;
}

- (CGRect)calculateFrameForEntryElement {
   
   CGFloat detailImageMargin = 2.0f;
   CGFloat detailImageSize = self.contentView.frame.size.height - 2 * detailImageMargin;
   
   _imageElement.parentSection.entryPosition = CGRectMake(self.contentView.frame.size.width - detailImageMargin - detailImageSize,
                                                          detailImageMargin, detailImageSize, detailImageSize);
   
   return _imageElement.parentSection.entryPosition;
}

- (void)prepareForElement:(QImageElement *)element inTableView:(QuickDialogTableView *)tableView {
   
   _quickformTableView = tableView;
   _imageElement = element;
   
   self.textLabel.text = element.title;
   self.textLabel.textColor = [UIColor lightGrayColor];
   self.textLabel.textAlignment = UITextAlignmentLeft;
   self.imageView.image = element.image;
   self.detailImageView.image = element.detailImage;
   self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)layoutSubviews {
   [super layoutSubviews];
   [self recalculateDetailImageViewPosition];
}

- (void)recalculateDetailImageViewPosition {
   _imageElement.parentSection.entryPosition = CGRectZero;
   _detailImageView.frame = [self calculateFrameForEntryElement];
   CGRect labelFrame = self.textLabel.frame;
   self.textLabel.frame = CGRectMake(labelFrame.origin.x, labelFrame.origin.y,
                                     _imageElement.parentSection.entryPosition.origin.x-20, labelFrame.size.height);
}

- (void)prepareForReuse {
   _quickformTableView = nil;
   _imageElement = nil;
}

@end
