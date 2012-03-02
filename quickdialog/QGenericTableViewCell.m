//
//  QGenericTableViewCell.m
//  QuickDialog
//
//  Created by Ken Cooper on 2/28/12.
//  Copyright (c) 2012 Coopercode, LLC. All rights reserved.
//

#import "QGenericTableViewCell.h"

@implementation QGenericTableViewCell

@synthesize eventDelegate=_eventDelegate;

+ (CGFloat)getRowHeightForTableView:(QuickDialogTableView *)tableView element: (QGenericElement *)element;
{
    return 0;
}

- (void)prepareForElement:(QGenericElement *)element inTableView:(QuickDialogTableView *)tableView
{
}

@end
