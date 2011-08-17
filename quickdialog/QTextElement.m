//
//  Created by escoz on 7/12/11.
//
//  To change this template use File | Settings | File Templates.
//


#import "QElement.h"
#import "QTextElement.h"
#import "QuickDialogTableView.h"


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
        cell.textLabel.textColor = _color;
        cell.textLabel.text = _text;
    }
    return cell;
}

- (void)selected:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller indexPath:(NSIndexPath *)indexPath {
}

- (CGFloat)getRowHeightForTableView:(QuickDialogTableView *)tableView {

    if (_text==nil || _text == @""){
        return [super getRowHeightForTableView:tableView];
    }
    CGSize constraint = CGSizeMake(300, 20000);
    CGSize  size= [_text sizeWithFont:_font constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    return size.height+20;
}

@end