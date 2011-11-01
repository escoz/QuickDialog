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

@implementation QTextElement

@synthesize text = _text;
@synthesize font = _font;
@synthesize color = _color;


- (QTextElement *)initWithText:(NSString *)text {
    self = [super init];
    _text = text;
    _font = [UIFont systemFontOfSize:14];

    return self;
}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuickfromTextElement"];
    if (cell==nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"QuickfromTextElement"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
        cell.textLabel.font = _font;
        cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
        cell.textLabel.numberOfLines = 0;
        if([cell.textLabel respondsToSelector:@selector(textLabel:)]) {
            cell.textLabel.textColor = _color;
        }
        cell.textLabel.text = _text;
    }
    return cell;
}

- (void)selected:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller indexPath:(NSIndexPath *)indexPath {
    self.onSelected();
}

- (CGFloat)getRowHeightForTableView:(QuickDialogTableView *)tableView {

    if (_text==nil || _text == @""){
        return [super getRowHeightForTableView:tableView];
    }
    CGSize constraint = CGSizeMake(300, 20000);
    CGSize  size= [_text sizeWithFont:_font constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    return size.height+20;
}

- (void)fetchValueIntoObject:(id)obj {
	if (_key==nil)
		return;
	
	[obj setValue:_text forKey:_key];
}

@end