//
//  Created by escoz on 7/11/11.
//
//  To change this template use File | Settings | File Templates.
//


#import "QElement.h"
#import "QLabelElement.h"
#import "QFloatElement.h"
#import "QuickDialogTableView.h"

@implementation QFloatElement

@synthesize floatValue = _floatValue;

- (QFloatElement *)initWithTitle:(NSString *)title value:(float)value {
    self = [super initWithTitle:title Value:nil] ;
    _floatValue = value;
    return self;
}


- (QElement *)initWithValue:(float)value {
    self = [super init];
    _floatValue = value;

    return self;
}

- (void)fetchValueIntoObject:(id)obj {
	if (_key==nil)
		return;
    [obj setValue:[NSNumber numberWithFloat:_floatValue] forKey:_key];
}

- (CGFloat)calculateSliderWidth:(QuickDialogTableView *)view cell:(UITableViewCell *)cell {
    if (_title==nil)
        return view.contentSize.width-40;

    return view.contentSize.width - [cell.textLabel.text sizeWithFont:[UIFont boldSystemFontOfSize:17]].width - 50;
}

- (void)valueChanged:(UISlider *)slider {
   _floatValue = slider.value;
}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {
    UITableViewCell *cell = [super getCellForTableView:tableView controller:controller];

    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, [self calculateSliderWidth:tableView cell:cell], 20)];
    [slider addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];

    slider.value = _floatValue;
    cell.accessoryView = slider;
    return cell;
}





@end