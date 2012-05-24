//
//  Created by escoz on 1/15/12.
//
#import "QSegmentedElement.h"

@implementation QSegmentedElement {
    QuickDialogController *_controller;
}
- (void)setItems:(NSArray *)anItems {
    if (_items != anItems) {
        _items = anItems;
    }
}

- (QSegmentedElement *)initWithItems:(NSArray *)stringArray selected:(NSInteger)selected {
    self = [super initWithItems:stringArray selected:selected];
    return self;
}

- (QSegmentedElement *)initWithItems:(NSArray *)stringArray selected:(NSInteger)selected title:(NSString *)title {
    self = [super initWithItems:stringArray selected:selected title:title];
    return self;
}

- (QSegmentedElement *)init {
    self = [super init];
    return self;
}

- (void)handleSegmentedControlValueChanged:(id)control {
    _selected = ((UISegmentedControl *)control).selectedSegmentIndex;
    [self handleElementSelected:_controller];
}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {
    _controller = controller;
    QTableViewCell *cell = [[QTableViewCell alloc] init];
    cell.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    cell.backgroundColor = [UIColor clearColor];
    UISegmentedControl *control = [[UISegmentedControl alloc] initWithItems:_items];
    [control addTarget:self action:@selector(handleSegmentedControlValueChanged:)   forControlEvents:UIControlEventValueChanged];
    const BOOL isPhone = [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone;
    control.frame = CGRectMake(isPhone ? 9 : 30, 0, isPhone ? 302 : 260, 46);
    control.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    control.segmentedControlStyle = UISegmentedControlStyleBar;
    control.selectedSegmentIndex = _selected;
    control.tag = 4321;

    [cell addSubview:control];
    return cell;
}

@end