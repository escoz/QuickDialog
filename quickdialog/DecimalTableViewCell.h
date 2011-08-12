//
//  Created by escoz on 8/8/11.
//
//  To change this template use File | Settings | File Templates.
//


#import <Foundation/Foundation.h>

@class EntryTableViewCell;


@interface DecimalTableViewCell : EntryTableViewCell<UITextFieldDelegate>  {

}

- (void)prepareForElement:(EntryElement *)element inTableView:(QuickDialogTableView *)view;

@end