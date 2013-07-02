//
//  Created by escoz on 1/15/12.
//
#import "QSegmentedElement.h"

@implementation QSegmentedElement {
    QuickDialogController *_controller;
}
- (void)setItems:(NSArray *)anItems {
    if (_items != anItems) {
        NSMutableArray * n = [NSMutableArray arrayWithCapacity:anItems.count];
        for (id i in anItems)
        {
            UIImage * img = nil;
            if ([i isKindOfClass:[NSString class]])
                img = [UIImage imageNamed:i];
            
            if (img)
                [n addObject:img];
            else
                [n addObject:i];
        }
        _items = n;
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
    
    [self handleEditingChanged];
}


- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {
    _controller = controller;
    QTableViewCell *cell = [[QTableViewCell alloc] init];
    cell.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    cell.backgroundColor = [UIColor clearColor];
    UISegmentedControl *control = [[UISegmentedControl alloc] initWithItems:_items];
    [control addTarget:self action:@selector(handleSegmentedControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    control.frame = cell.contentView.bounds;
    control.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    control.segmentedControlStyle = UISegmentedControlStyleBar;
    control.selectedSegmentIndex = _selected;
    control.tag = 4321;
    
    [cell.contentView addSubview:control];
    return cell;
}

- (BOOL)canTakeFocus {
    return NO;
}

@end
