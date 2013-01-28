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

#import "QImageTableViewCell.h"
#import "QImageElement.h"
static NSString *kDetailImageValueObservanceContext = @"imageValue";

@interface QImageTableViewCell ()

@property (nonatomic, retain) QImageElement *imageElement;

@end

@implementation QImageTableViewCell

@synthesize imageElement = _imageElement;
@synthesize imageViewButton = _imageViewButton;

- (QImageTableViewCell *)init {
   self = [self initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"QuickformImageElement"];
   if (self!=nil){
      [self createSubviews];
      self.selectionStyle = UITableViewCellSelectionStyleBlue;
      [self addObserver:self forKeyPath:@"imageElement.imageValue" options:0 context:(__bridge void *)(kDetailImageValueObservanceContext)];
   }
   return self;
}

- (void)createSubviews {
    _imageViewButton = [[UIButton alloc] init];
    _imageViewButton.contentMode = UIViewContentModeScaleAspectFill;
    _imageViewButton.layer.cornerRadius = 7.2f;
    _imageViewButton.layer.masksToBounds = YES;
    _imageViewButton.contentMode = UIViewContentModeScaleAspectFill;
    _imageViewButton.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.1];
    _imageViewButton.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
    [_imageViewButton addTarget:self action:@selector(handleImageSelected) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_imageViewButton];
    [self setNeedsLayout];
}

- (void)handleImageSelected {
    if (((QImageElement *)_entryElement).imageValue!=nil){

    } else{

    }
}

- (void)prepareForElement:(QEntryElement *)element inTableView:(QuickDialogTableView *)tableView {
   [super prepareForElement:element inTableView:tableView];

   self.imageElement = (QImageElement *) element;

   self.imageView.image = self.imageElement.image;
   self.imageViewButton.imageView.image = self.imageElement.imageValue;
}

- (void)layoutSubviews {
   [super layoutSubviews];
   [self recalculateDetailImageViewPosition];
}

- (void)recalculateDetailImageViewPosition {

   CGFloat detailImageMargin = 2.0f;
   CGFloat detailImageSize = self.contentView.frame.size.height - 2 * detailImageMargin;

   _imageViewButton.frame = CGRectMake(self.contentView.frame.size.width - detailImageMargin - detailImageSize,
                                       detailImageMargin, detailImageSize, detailImageSize);
    _imageElement.parentSection.entryPosition = _imageViewButton.frame;

   CGRect labelFrame = self.textLabel.frame;
   CGFloat extra = (_entryElement.image == NULL) ? 10.0f : _entryElement.image.size.width + 20.0f;
   self.textLabel.frame = CGRectMake(labelFrame.origin.x, labelFrame.origin.y,
                                     _imageElement.parentSection.entryPosition.origin.x - extra - detailImageMargin, labelFrame.size.height);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
   if (context == (__bridge void *)(kDetailImageValueObservanceContext)) {
       [self.imageViewButton setImage:self.imageElement.imageValue forState:UIControlStateNormal];
   } else {
      [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
   }
}

- (void)dealloc {
   [self removeObserver:self forKeyPath:@"imageElement.imageValue" context:(__bridge void *)(kDetailImageValueObservanceContext)];
}

@end
