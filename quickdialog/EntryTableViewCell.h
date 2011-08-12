//
//  Created by escoz on 7/9/11.
//
//  To change this template use File | Settings | File Templates.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class EntryElement;
@class QuickDialogTableView;


@interface EntryTableViewCell : UITableViewCell<UITextFieldDelegate> {

    EntryElement *_entryElement;
    UITextField *_textField;

@protected
    QuickDialogTableView *_quickformTableView;
    UIToolbar *_actionBar;
}

- (void)prepareForElement:(EntryElement *)element inTableView:(QuickDialogTableView *)tableView;

- (void)createSubviews;

- (EntryElement *)findNextElementToFocusOn;
- (EntryElement *)findPreviousElementToFocusOn;

- (void)recalculatePositioning;


@end