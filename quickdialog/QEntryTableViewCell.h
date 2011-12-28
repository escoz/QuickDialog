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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ForwardedUITextFieldDelegate <NSObject>

@optional
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
- (void)textFieldEditingChanged:(UITextField *)textFieldEditingChanged;
- (void)textFieldDidBeginEditing:(UITextField *)textField;
- (void)textFieldDidEndEditing:(UITextField *)textField;
- (BOOL)textFieldShouldReturn:(UITextField *)textField;
- (BOOL)textFieldMustReturn:(UITextField *)textField;

@end

@class QEntryElement;
@class QuickDialogTableView;


@interface QEntryTableViewCell : UITableViewCell<UITextFieldDelegate> {

    QEntryElement *_entryElement;
    UITextField *_textField;

@protected
    __unsafe_unretained QuickDialogTableView *_quickformTableView;
    UIToolbar *_actionBar;
}

@property(nonatomic, strong) UITextField *textField;
@property(nonatomic, weak) id<ForwardedUITextFieldDelegate> delegate;

- (void)prepareForElement:(QEntryElement *)element inTableView:(QuickDialogTableView *)tableView;

- (void)createSubviews;

- (QEntryElement *)findNextElementToFocusOn;
- (QEntryElement *)findPreviousElementToFocusOn;

- (void)recalculateEntryFieldPosition;


@end