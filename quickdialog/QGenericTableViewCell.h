//
//  QGenericTableViewCell.h
//  QuickDialog
//
//  Created by Ken Cooper on 2/28/12.
//  Copyright (c) 2012 Coopercode, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QGenericElement.h"

@interface QGenericTableViewCell : UITableViewCell

+ (CGFloat)getRowHeightForTableView:(QuickDialogTableView *)tableView element: (QGenericElement *)element;

- (void)prepareForElement:(QGenericElement *)element inTableView:(QuickDialogTableView *)tableView;
@end
