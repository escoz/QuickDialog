//
//  Created by escoz on 7/9/11.
//
//  To change this template use File | Settings | File Templates.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class QEntryElement;
@class QuickDialogTableView;


@interface QEntryTableViewCell : UITableViewCell<UITextFieldDelegate> {

    QEntryElement *_entryElement;
    UITextField *_textField;

@protected
    QuickDialogTableView *_quickformTableView;
    UIToolbar *_actionBar;
}

- (void)prepareForElement:(QEntryElement *)element inTableView:(QuickDialogTableView *)tableView;

- (void)createSubviews;

- (QEntryElement *)findNextElementToFocusOn;
- (QEntryElement *)findPreviousElementToFocusOn;

- (void)recalculatePositioning;


@end