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

#import "QTextElement.h"
#import "QElement+Appearance.h"
#import "QAppearance.h"

@implementation QTextElement

- (instancetype)init {
   self = [super init];
    if (self)
    {
        [self internalInit:nil];
    }
    return self;
}

- (instancetype)initWithText:(NSString *)text {
    self = [self init];
    if (self)
    {
        [self internalInit:text];
    }
    return self;
}

- (void)internalInit:(NSString *)text
{
    self.text = text;
    self.verticalMargin = 12;
    self.color = [UIColor blackColor];
}


- (void)setCurrentCell:(UITableViewCell *)cell
{
    super.currentCell = cell;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.detailTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.detailTextLabel.numberOfLines = 0;

    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    cell.textLabel.text = self.title;
    cell.detailTextLabel.font = self.appearance.valueFont;
    cell.detailTextLabel.textColor = _color;
    cell.detailTextLabel.text = _text;

    cell.imageView.image = _image;
}


- (CGFloat)getRowHeightForTableView:(QuickDialogTableView *)tableView {

    if (_text.length == 0){
        return [super getRowHeightForTableView:tableView];
    }
    CGSize constraint = CGSizeMake(tableView.frame.size.width-(tableView.root.grouped ? 40.f : 20.f), CGFLOAT_MAX);
    CGSize size = [self.text boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.appearance.valueFont} context:nil].size;

	CGFloat predictedHeight = size.height + (self.verticalMargin * 2);
    if (self.title!=nil)
    {
        CGRect labelSize = [self.title boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.appearance.titleFont} context:nil];
        predictedHeight += labelSize.size.height;
    }

	return (_height >= predictedHeight) ? _height : predictedHeight;
}

- (void)fetchValueIntoObject:(id)obj {
	if (_key==nil)
		return;
	
	[obj setValue:_text forKey:_key];
}

@end
