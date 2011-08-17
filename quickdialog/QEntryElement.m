//
//  Created by escoz on 7/8/11.
//
//  To change this template use File | Settings | File Templates.
//


#import "QElement.h"
#import "QLabelElement.h"
#import "QEntryElement.h"
#import "QEntryTableViewCell.h"
#import "QuickDialogTableView.h"


@implementation QEntryElement

@synthesize textValue = _textValue;
@synthesize placeholder = _placeholder;
@synthesize hiddenToolbar = _hiddenToolbar;
@synthesize isPassword = _isPassword;


- (QEntryElement *)initWithTitle:(NSString *)title Value:(NSString *)value Placeholder:(NSString *)placeholder {
    self = [self initWithTitle:title Value:nil];
    _textValue = value;
    _placeholder = placeholder;
    return self;
}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {

    QEntryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuickformEntryElement"];
    if (cell==nil){
        cell = [[QEntryTableViewCell alloc] init];
    }
    
    [cell prepareForElement:self inTableView:tableView];
    return cell;

}

- (void)selected:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller indexPath:(NSIndexPath *)indexPath {
    [super selected:tableView controller:controller indexPath:indexPath];
}

- (void)fetchValueIntoObject:(id)obj {
	if (_key==nil)
		return;
	
	[obj setValue:_textValue forKey:_key];
}


@end