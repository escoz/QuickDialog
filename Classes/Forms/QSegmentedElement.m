//
//  Created by escoz on 1/15/12.
//
#import "QSegmentedElement.h"

@implementation QSegmentedElement {
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

- (instancetype)initWithItems:(NSArray *)stringArray selected:(NSInteger)selected {
    self = [super initWithItems:stringArray selected:selected];
    return self;
}

- (instancetype)initWithItems:(NSArray *)stringArray selected:(NSInteger)selected title:(NSString *)title {
    self = [super initWithItems:stringArray selected:selected title:title];
    return self;
}

- (instancetype)init {
    self = [super init];
    return self;
}

- (void)handleSegmentedControlValueChanged:(id)control {
    _selected = ((UISegmentedControl *)control).selectedSegmentIndex;

    [self performAction];
    
    [self handleEditingChanged];
}

- (void)setCurrentCell:(UITableViewCell *)cell
{
    super.currentCell = cell;
    cell.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    cell.backgroundColor = [UIColor clearColor];
    UISegmentedControl *control = [[UISegmentedControl alloc] initWithItems:_items];
    [control addTarget:self action:@selector(handleSegmentedControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    control.frame = CGRectMake( 4, 4, cell.contentView.bounds.size.width - 8, cell.contentView.bounds.size.height - 8);
    control.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    control.selectedSegmentIndex = _selected;
    control.tag = 4321;
    [cell.contentView addSubview:control];

}

- (BOOL)canTakeFocus {
    return NO;
}

@end
