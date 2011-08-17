//
//  Created by escoz on 8/8/11.
//
//  To change this template use File | Settings | File Templates.
//


#import <Foundation/Foundation.h>

@class QEntryTableViewCell;


@interface QDecimalTableViewCell : QEntryTableViewCell <UITextFieldDelegate>  {

}

- (void)prepareForElement:(QEntryElement *)element inTableView:(QuickDialogTableView *)view;

@end