//
//  Created by escoz on 8/8/11.
//
//  To change this template use File | Settings | File Templates.
//


#import "QDecimalElement.h"
#import "QEntryTableViewCell.h"
#import "QDecimalTableViewCell.h"
#import "QuickDialogTableView.h"


@implementation QDecimalElement {
    
@protected
    NSUInteger _fractionDigits;
}
@synthesize floatValue = _floatValue;
@synthesize fractionDigits = _fractionDigits;


- (QDecimalElement *)initWithTitle:(NSString *)title value:(float)value {
    self = [super initWithTitle:title Value:nil] ;
    _floatValue = value;
    return self;
}


- (QDecimalElement *)initWithValue:(float)value {
    self = [super init];
    _floatValue = value;
    return self;
}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {

    QDecimalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuickformDecimalElement"];
    if (cell==nil){
        cell = [[QDecimalTableViewCell alloc] init];
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