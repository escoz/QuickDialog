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
    _selected = ((UISegmentedControl *)control).selectedSegmentIndex - 1;
    if (self.onValueChanged!=nil)
        self.onValueChanged(self);

    [self handleElementSelected:_controller];
}

/*
 
- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {
    _controller = controller;
    QTableViewCell *cell = [[QTableViewCell alloc] init];
    cell.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    cell.backgroundColor = [UIColor clearColor];
    UISegmentedControl *control = [[UISegmentedControl alloc] initWithItems:_items];
    [control addTarget:self action:@selector(handleSegmentedControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    const BOOL isPhone = [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone;
    control.frame = CGRectMake(isPhone ? 9 : 30, 0, isPhone ? 302 : 260, self.height);
    control.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    control.segmentedControlStyle = UISegmentedControlStyleBar;
    control.selectedSegmentIndex = _selected;
    control.tag = 4321;
    
    [cell addSubview:control];
    return cell;
}

*/

// heavily modified to clip the round borders of the segmented control with extra elements of defined size
- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {
    _controller = controller;
    QTableViewCell *cell = [[QTableViewCell alloc] init];
    cell.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    cell.backgroundColor = [UIColor clearColor];
    
    NSMutableArray * item = [NSMutableArray arrayWithArray:_items];
    [item addObject:@""];
    [item insertObject:@"" atIndex:0];
    CGRect frame = cell.contentView.bounds;
    frame.origin.x -=1;
    frame.size.width += 2;
    frame.size.height += 1;    
    UIView * container = [[UIView alloc] initWithFrame: frame];
    container.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    container.clipsToBounds = YES;
    [cell.contentView addSubview:container];
    
    UISegmentedControl *control = [[UISegmentedControl alloc] initWithItems:item];
    [control addTarget:self action:@selector(handleSegmentedControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    frame.origin.x -= 9;
    frame.size.width += 20;
    control.frame = frame;
    control.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    control.segmentedControlStyle = 6;
    control.selectedSegmentIndex = _selected;
    control.tag = 4321;
    [control setEnabled:NO forSegmentAtIndex:0];
    [control setEnabled:NO forSegmentAtIndex:item.count-1];
    [control setWidth:10 forSegmentAtIndex:0];
    [control setWidth:10 forSegmentAtIndex:item.count-1];

    control.userInteractionEnabled = self.enabled;

    [container addSubview:control];
    return cell;
}

- (BOOL)canTakeFocus {
    return NO;
}

@end
