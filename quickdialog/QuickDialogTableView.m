//                                
// Copyright 2011 ESCOZ Inc  - http://escoz.com
// 
// Licensed under the Apache License, Version 2.0 (the "License"); you may not use this 
// file except in compliance with the License. You may obtain a copy of the License at 
// 
// http://www.apache.org/licenses/LICENSE-2.0 
// 
// Unless required by applicable law or agreed to in writing, software distributed under
// the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF 
// ANY KIND, either express or implied. See the License for the specific language governing
// permissions and limitations under the License.
//

@implementation QuickDialogTableView {
    BOOL _deselectRowWhenViewAppears;
}

@synthesize root = _root;
@synthesize styleProvider = _styleProvider;
@synthesize deselectRowWhenViewAppears = _deselectRowWhenViewAppears;

- (QuickDialogController *)controller {
    return _controller;
}

- (QuickDialogTableView *)initWithController:(QuickDialogController *)controller {
    self = [super initWithFrame:CGRectMake(0, 0, 0, 0) style:controller.root.grouped ? UITableViewStyleGrouped : UITableViewStylePlain];
    if (self!=nil){
        _controller = controller;
        self.root = _controller.root;
        self.deselectRowWhenViewAppears = YES;

        quickformDataSource = [[QuickDialogDataSource alloc] initForTableView:self];
        self.dataSource = quickformDataSource;

        quickformDelegate = [[QuickDialogTableDelegate alloc] initForTableView:self];
        self.delegate = quickformDelegate;

        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    return self;
}

-(void)setRoot:(QRootElement *)root{
    _root = root;
    for (QSection *section in _root.sections) {
        if (section.needsEditing == YES){
            [self setEditing:YES animated:YES];
            self.allowsSelectionDuringEditing = YES;
        }
    }
    [self reloadData];
}

- (NSIndexPath *)indexForElement:(QElement *)element {
    for (int i=0; i< [_root.sections count]; i++){
        QSection * currSection = [_root.sections objectAtIndex:(NSUInteger) i];

        for (int j=0; j< [currSection.elements count]; j++){
            QElement *currElement = [currSection.elements objectAtIndex:(NSUInteger) j];
            if (currElement == element){
                return [NSIndexPath indexPathForRow:j inSection:i];
            }
        }
    }
    return NULL;
}

- (NSIndexPath *)visibleIndexForElement:(QElement *)element {
    if (element.hidden)
        return NULL;
    
    NSUInteger s = 0;
    for (QSection * q in _root.sections)
    {
        if (!q.hidden)
        {
            NSUInteger e = 0;
            for (QElement * r in q.elements)
            {
                if (r == element)
                    return [NSIndexPath indexPathForRow:e inSection:s];
                ++e;
            }
        }
        ++s;
    }
    return NULL;
}

- (UITableViewCell *)cellForElement:(QElement *)element {
    if (element.hidden)
        return nil;
    return [self cellForRowAtIndexPath:[self visibleIndexForElement:element]];
}

- (void)viewWillAppear {
    NSArray *selected = nil;
    if ([self indexPathForSelectedRow]!=nil && _deselectRowWhenViewAppears){
        NSIndexPath *selectedRowIndex = [self indexPathForSelectedRow];
        selected = [NSArray arrayWithObject:selectedRowIndex];
        [self reloadRowsAtIndexPaths:selected withRowAnimation:UITableViewRowAnimationNone];
        [self selectRowAtIndexPath:selectedRowIndex animated:NO scrollPosition:UITableViewScrollPositionNone];
        [self deselectRowAtIndexPath:selectedRowIndex animated:YES];
    };
}

- (void)reloadCellForElements:(QElement *)firstElement, ... {
    va_list args;
    va_start(args, firstElement);
    NSMutableArray *indexes = [[NSMutableArray alloc] init];
    QElement * element = firstElement;
    while (element != nil) {
        if (!element.hidden)
            [indexes addObject:element.getIndexPath];
        element = va_arg(args, QElement *);
    }
    [self reloadRowsAtIndexPaths:indexes withRowAnimation:UITableViewRowAnimationNone];

    va_end(args);
}

@end