//
//  Created by escoz on 7/8/11.
//
//  To change this template use File | Settings | File Templates.
//


#import "QElement.h"
#import "QLabelElement.h"
#import "QBooleanElement.h"
#import "QuickDialogTableView.h"


@implementation QBooleanElement


@synthesize onImage = _onImage;
@synthesize offImage = _offImage;
@synthesize boolValue = _boolValue;
@synthesize enabled = _enabled;


- (QBooleanElement *)init {
    self = [self initWithTitle:nil BoolValue:YES];
    return self;
}

- (QBooleanElement *)initWithTitle:(NSString *)title BoolValue:(BOOL)value {
    self = [self initWithTitle:title Value:nil];
    _boolValue = value;
    _enabled = YES;
    return self;
}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {
    UITableViewCell *cell = [super getCellForTableView:tableView controller:controller];
    cell.accessoryType = self.sections!= nil || self.controllerAction!=nil ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
    cell.selectionStyle = self.sections!= nil || self.controllerAction!=nil ? UITableViewCellSelectionStyleBlue: UITableViewCellSelectionStyleNone;
    
    if ((_onImage==nil) && (_offImage==nil))  {
        UISwitch *boolSwitch = [[UISwitch alloc] init];
        boolSwitch.on = _boolValue;
        boolSwitch.enabled = _enabled;
        [boolSwitch addTarget:self action:@selector(switched:) forControlEvents:UIControlEventValueChanged];
        cell.accessoryView = boolSwitch;

    } else {
        UIImageView *boolSwitch = [[UIImageView alloc] initWithImage: _boolValue ? _onImage : _offImage];
        cell.accessoryView = boolSwitch;
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    }

    return cell;
}

- (void)selected:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller indexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    _boolValue = !_boolValue;
    if ([cell.accessoryView class] == [UIImageView class]){
        ((UIImageView *)cell.accessoryView).image =  _boolValue ? _onImage : _offImage;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)switched:(id)boolSwitch {
    _boolValue = ((UISwitch *)boolSwitch).on;
}

- (void)fetchValueIntoObject:(id)obj {
	if (_key==nil)
		return;
    [obj setValue:[NSNumber numberWithBool:_boolValue] forKey:_key];
}


@end