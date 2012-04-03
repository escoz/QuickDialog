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
#import "UIImage+IMSExtensions.h"

@implementation QButtonImageElement

@synthesize height;
@synthesize image;
@synthesize baseImage;
@synthesize disabled;
@synthesize colours;

- (QButtonImageElement *)init {
    self = [super init];
    self.image = nil;
    self.height = 60;
    return self;
}

- (QButtonImageElement *)initWithTitle:(NSString *)title andImage:(UIImage*)theImage withRowHeight:(CGFloat)rowHeight;
{
    self = [super initWithTitle:title Value:nil];
    self.image = theImage;
    self.height = rowHeight;
    self.baseImage = theImage;
    disabled = NO;
    self.colours = [[QButtonImageColours alloc] initWithEnabled:[UIColor blueColor] andDisabled:[UIColor lightGrayColor]];
    return self;
}

- (QButtonImageElement *)initWithTitleAndColours:(NSString *)title andImage:(UIImage*)theImage withRowHeight:(CGFloat)rowHeight andColours:(QButtonImageColours*)theColours;
{
    self = [super initWithTitle:title Value:nil];
    self.image = theImage;
    self.height = rowHeight;
    self.baseImage = theImage;
    disabled = NO;
    self.colours = theColours;
    return self;
}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuickformButtonImageElement"];
    if (cell == nil){
        cell= [[QTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"QuickformButtonElement"];
    }
    if (self.image)
    {
        [[cell imageView] setImage:self.image];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    cell.textLabel.text = _title;
    cell.textLabel.textAlignment = UITextAlignmentLeft;
    if (disabled)
    {
        cell.textLabel.textColor = colours.disabledColor;
    }
    else
    {
        cell.textLabel.textColor = colours.enabledColor;
    }
    return cell;
}

- (void)selected:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller indexPath:(NSIndexPath *)indexPath {
    [super selected:tableView controller:controller indexPath:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)setRowHeight:(CGFloat)theHeight;
{
    self.height = theHeight;
}

- (CGFloat)getRowHeightForTableView:(QuickDialogTableView *)tableView {
    
	return self.height;
}

- (void)enable
{
    if (disabled)
    {
        image = self.baseImage;
        disabled = NO;
    }
}
- (void)disable
{
    if (!disabled)
    {
        image = [baseImage convertImageToGrayScale];
        disabled = YES;
    }
}

- (BOOL)isDisabled
{
    return disabled;
}

- (void)setTheColours:(QButtonImageColours *)theColours
{
    colours = theColours;
}

@end

