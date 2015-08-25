//
// Created by Eduardo Scoz on 1/11/14.
//
#import "QTableViewCell.h"
#import "QDateTimeInlineElement.h"
#import <Foundation/Foundation.h>


@interface QDateInlineTableViewCell : QTableViewCell

- (void)prepareForElement:(QDateTimeInlineElement *)element inTableView:(QuickDialogTableView *)tableView;

@end


