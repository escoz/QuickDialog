//
//  Created by escoz on 7/7/11.
//
//  To change this template use File | Settings | File Templates.
//


#import "QuickDialogDataSource.h"
#import "QuickDialogController.h"
#import "Section.h"
#import "Element.h"
#import "RootElement.h"
#import "QuickDialogTableView.h"
#import "SortingSection.h"
#import "QuickDialogStyleProvider.h"


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
    Section *section = [_tableView.root getSectionForIndex:indexPath.section];
    Element * element = [section.elements objectAtIndex:(NSUInteger) indexPath.row];
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
    return [[_tableView.root getSectionForIndex:indexPath.section] isKindOfClass:[SortingSection class]];
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    SortingSection *section = ((SortingSection *) [_tableView.root.sections objectAtIndex:(NSUInteger) sourceIndexPath.section]);
    [section moveElementFromRow:(NSUInteger) sourceIndexPath.row toRow:(NSUInteger) destinationIndexPath.row];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[_tableView.root getSectionForIndex:indexPath.section] isKindOfClass:[SortingSection class]];
}

@end