//
//  Created by escoz on 8/8/11.
//
//  To change this template use File | Settings | File Templates.
//


#import "DecimalElement.h"
#import "EntryTableViewCell.h"
#import "DecimalTableViewCell.h"
#import "QuickDialogTableView.h"


@implementation DecimalElement {
    
@protected
    NSUInteger _fractionDigits;
}
@synthesize floatValue = _floatValue;
@synthesize fractionDigits = _fractionDigits;


- (DecimalElement *)initWithTitle:(NSString *)title value:(float)value {
    self = [super initWithTitle:title Value:nil] ;
    _floatValue = value;
    return self;
}


- (DecimalElement *)initWithValue:(float)value {
    self = [super init];
    _floatValue = value;
    return self;
}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {

    DecimalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuickformDecimalElement"];
    if (cell==nil){
        cell = [[DecimalTableViewCell alloc] init];
    }
    [cell prepareForElement:self inTableView:tableView];
    return cell;

}

- (void)fetchValueIntoObject:(id)obj {
	if (_key==nil)
		return;
    [obj setValue:[NSNumber numberWithFloat:_floatValue] forKey:_key];
}

@end