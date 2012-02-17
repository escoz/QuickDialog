// created by Iain Stubbs but based on QEntryTableViewCell.h
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
#import "QuickDialog.h"
#import "DOAutocompleteTextField.h"

@class QEntryElement;
@class QuickDialogTableView;


@interface QAutoEntryTableViewCell : QTableViewCell<UITextFieldDelegate,DOAutocompleteTextFieldDelegate> {
    
    QAutoEntryElement *entryElement;
    DOAutocompleteTextField *txtField;
    NSArray* autos;
    UIColor *autoColor;
    
@protected
    __unsafe_unretained QuickDialogTableView *_quickformTableView;
}

@property(nonatomic, strong) DOAutocompleteTextField *txtField;
@property(nonatomic, retain) NSArray *autos;

- (void)prepareForElement:(QAutoEntryElement *)element inTableView:(QuickDialogTableView *)tableView;

- (void)createSubviews;

- (QAutoEntryElement *)findNextElementToFocusOn;
- (QAutoEntryElement *)findPreviousElementToFocusOn;

- (void)setAutoCompletes:(NSArray*)autoCompletes;
- (void)setAutoCompleteColor:(UIColor*)colour;

- (void)recalculateEntryFieldPosition;

- (NSString*)getLastAutoComplete;

@end