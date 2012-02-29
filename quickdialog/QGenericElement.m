//
//  QGenericElement.m
//  QuickDialog
//
//  Created by Ken Cooper on 2/28/12.
//  Copyright (c) 2012 Coopercode, LLC. All rights reserved.
//

#import "QGenericElement.h"
#import "QGenericTableViewCell.h"

@implementation QGenericElement {
    Class _tableCellSubclass;
}

@synthesize model=_model;

-(id)initWithTableCellSubclass:(Class)tableCellSubclass
{
    if (![tableCellSubclass isSubclassOfClass: [QGenericTableViewCell class]]) {
        [NSException raise:@"Invalid class" format:@"%s must be a subclass of QGenericTableViewCell", NSStringFromClass(tableCellSubclass)];
    }
    if (self = [super init]) {
        _tableCellSubclass = tableCellSubclass;
    }
    return self;
}

- (CGFloat)getRowHeightForTableView:(QuickDialogTableView *)tableView 
{
    return [_tableCellSubclass getRowHeightForTableView: tableView element: self];
}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller 
{
    NSString *identifier = NSStringFromClass(_tableCellSubclass);
    QGenericTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil){
        cell = [[_tableCellSubclass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    [cell prepareForElement:self inTableView:tableView];
    return cell;
    
}

@end

