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

static NSString *kDetailImageValueObservanceContext = @"detailImageValue";

@interface QImageTableViewCell ()

@property (nonatomic, retain) QImageElement *imageElement;

@end

@implementation QImageTableViewCell

@synthesize imageElement = _imageElement;
@synthesize detailImageView = _detailImageView;

- (QImageTableViewCell *)init {
   self = [self initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"QuickformImageElement"];
   if (self!=nil){
      [self createSubviews];
      self.selectionStyle = UITableViewCellSelectionStyleBlue;
      [self addObserver:self forKeyPath:@"imageElement.detailImageValue" options:0 context:(__bridge void *)(kDetailImageValueObservanceContext)];
   }
   return self;
}

- (void)createSubviews {
   _detailImageView = [[UIImageView alloc] init];
   _detailImageView.contentMode = UIViewContentModeScaleAspectFill;
   _detailImageView.layer.cornerRadius = 7.0f;
   _detailImageView.layer.masksToBounds = YES;
   _detailImageView.layer.borderWidth = 1.0f;
   _detailImageView.layer.borderColor = [UIColor colorWithWhite:0.2f alpha:0.4f].CGColor;
   _detailImageView.contentMode = UIViewContentModeScaleAspectFill;
   _detailImageView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.3];
   _detailImageView.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
   [self.contentView addSubview:_detailImageView];
   [self setNeedsLayout];
}

- (void)prepareForElement:(QImageElement *)element inTableView:(QuickDialogTableView *)tableView {
   [super prepareForElement:element inTableView:tableView];

   self.imageElement = element;

   self.imageView.image = self.imageElement.image;
   self.detailImageView.image = self.imageElement.detailImageValue;
}

- (void)layoutSubviews {
   [super layoutSubviews];
   [self recalculateDetailImageViewPosition];
}

- (void)recalculateDetailImageViewPosition {

   CGFloat detailImageMargin = 2.0f;
   CGFloat detailImageSize = self.contentView.frame.size.height - 2 * detailImageMargin;

   _detailImageView.frame = CGRectMake(self.contentView.frame.size.width - detailImageMargin - detailImageSize,
                                       detailImageMargin, detailImageSize, detailImageSize);
    _imageElement.parentSection.entryPosition = _detailImageView.frame;

   CGRect labelFrame = self.textLabel.frame;
   CGFloat extra = (_entryElement.image == NULL) ? 10.0f : _entryElement.image.size.width + 20.0f;
   self.textLabel.frame = CGRectMake(labelFrame.origin.x, labelFrame.origin.y,
                                     _imageElement.parentSection.entryPosition.origin.x - extra - detailImageMargin, labelFrame.size.height);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
   if (context == (__bridge void *)(kDetailImageValueObservanceContext)) {
      self.detailImageView.image = self.imageElement.detailImageValue;
   } else {
      [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
   }
}

- (void)dealloc {
   [self removeObserver:self forKeyPath:@"imageElement.detailImageValue" context:(__bridge void *)(kDetailImageValueObservanceContext)];
}

@end
