//
//  Created by escoz on 7/8/11.
//
//  To change this template use File | Settings | File Templates.
//


#import "Element.h"
#import "LabelElement.h"
#import "EntryElement.h"
#import "EntryTableViewCell.h"
#import "QuickDialogTableView.h"


@implementation EntryElement

@synthesize textValue = _textValue;
@synthesize placeholder = _placeholder;
@synthesize hiddenToolbar = _hiddenToolbar;
@synthesize isPassword = _isPassword;


- (EntryElement *)initWithTitle:(NSString *)title Value:(NSString *)value Placeholder:(NSString *)placeholder {
    self = [self initWithTitle:title Value:nil];
    _textValue = value;
    _placeholder = placeholder;
    return self;
}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {

    EntryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuickformEntryElement"];
    if (cell==nil){
        cell = [[EntryTableViewCell alloc] init];
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