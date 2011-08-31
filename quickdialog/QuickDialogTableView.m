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

#import "QuickDialogTableView.h"

@implementation QuickDialogTableView {
    
}

@synthesize root = _root;
@synthesize selectedCell = _selectedCell;
@synthesize styleProvider = _styleProvider;


- (QuickDialogController *)controller {
    return _controller;
}

- (QuickDialogTableView *)initWithController:(QuickDialogController *)controller {
    self = [super initWithFrame:CGRectMake(0, 0, 0, 0) style:controller.root.grouped ? UITableViewStyleGrouped : UITableViewStylePlain];
    if (self!=nil){
        _controller = controller;
        self.root = _controller.root;

        quickformDataSource = [[QuickDialogDataSource alloc] initForTableView:self];
        self.dataSource = quickformDataSource;

        quickformDelegate = [[QuickDialogTableDelegate alloc] initForTableView:self];
        self.delegate = quickformDelegate;
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


- (UITableViewCell *)cellForElement:(QElement *)element {
    for (int i=0; i< [_root.sections count]; i++){
        QSection * currSection = [_root.sections objectAtIndex:(NSUInteger) i];

        for (int j=0; j< [currSection.elements count]; j++){
            QElement *currElement = [currSection.elements objectAtIndex:(NSUInteger) j];
            if (currElement == element){
                NSIndexPath *path = [NSIndexPath indexPathForRow:j inSection:i];
                return [self cellForRowAtIndexPath:path];
            }
        }
    }

    return NULL;
}

- (void)viewWillAppear {

    NSArray *selected = nil;
    if ([self indexPathForSelectedRow]!=nil){
        NSIndexPath *selectedRowIndex = [self indexPathForSelectedRow];
        selected = [NSArray arrayWithObject:selectedRowIndex];
        [self reloadRowsAtIndexPaths:selected withRowAnimation:NO];
        [self selectRowAtIndexPath:selectedRowIndex animated:NO scrollPosition:UITableViewScrollPositionNone];
        [self deselectRowAtIndexPath:selectedRowIndex animated:YES];
    };
}
@end