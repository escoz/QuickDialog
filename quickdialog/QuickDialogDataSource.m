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

#import "QuickDialogDataSource.h"
#import "QSortingSection.h"

@implementation QuickDialogDataSource

- (id <UITableViewDataSource>)initForTableView:(QuickDialogTableView *)tableView {
    self = [super init];
    if (self) {
       _tableView = tableView;
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_tableView.root getSectionForIndex:section].elements.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QSection *section = [_tableView.root getSectionForIndex:indexPath.section];
    QElement * element = [section.elements objectAtIndex:(NSUInteger) indexPath.row];
    UITableViewCell *cell = [element getCellForTableView:(QuickDialogTableView *) tableView controller:_tableView.controller];
    if (_tableView.styleProvider!=nil){
        [_tableView.styleProvider cell:cell willAppearForElement:element atIndexPath:indexPath];
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_tableView.root numberOfSections];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [_tableView.root getSectionForIndex:section].title;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return [_tableView.root getSectionForIndex:section].footer;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[_tableView.root getSectionForIndex:indexPath.section] isKindOfClass:[QSortingSection class]];
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    QSortingSection *section = ((QSortingSection *) [_tableView.root.sections objectAtIndex:(NSUInteger) sourceIndexPath.section]);
    [section moveElementFromRow:(NSUInteger) sourceIndexPath.row toRow:(NSUInteger) destinationIndexPath.row];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[_tableView.root getSectionForIndex:indexPath.section] isKindOfClass:[QSortingSection class]];
}

@end