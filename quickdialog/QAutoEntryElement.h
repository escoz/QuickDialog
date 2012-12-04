// created by Iain Stubbs but based on the QEntryElement.h
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
#import "QLabelElement.h"
#import "DOAutocompleteTextField.h"

#import "QEntryElement.h"


@interface QAutoEntryElement : QEntryElement <UITextInputTraits, DOAutocompleteTextFieldDelegate>

@property(nonatomic, retain) NSString *textValue;
@property(nonatomic, retain) NSString *placeholder;
@property(nonatomic, retain) NSArray *autoCompleteValues;
@property(nonatomic, retain) UIColor *autoCompleteColor;
@property(assign) BOOL hiddenToolbar;
@property(nonatomic, retain) NSString *lastAutoComplete;

@property(nonatomic, unsafe_unretained) id<QuickDialogEntryElementDelegate> delegate;

@property(nonatomic) UITextAutocapitalizationType autocapitalizationType; // default is UITextAutocapitalizationTypeSentences
@property(nonatomic) UITextAutocorrectionType autocorrectionType;         // default is UITextAutocorrectionTypeDefault
@property(nonatomic) UIKeyboardType keyboardType;                         // default is UIKeyboardTypeDefault
@property(nonatomic) UIKeyboardAppearance keyboardAppearance;             // default is UIKeyboardAppearanceDefault
@property(nonatomic) UIReturnKeyType returnKeyType;                       // default is UIReturnKeyDefault (See note under UIReturnKeyType enum)
@property(nonatomic) BOOL enablesReturnKeyAutomatically;                  // default is NO (when YES, will automatically disable return key when text widget has zero-length contents, and will automatically enable when text widget has non-zero-length contents)
@property(nonatomic,getter=isSecureTextEntry) BOOL secureTextEntry;       // default is NO

- (QAutoEntryElement *)init;

- (QAutoEntryElement *)initWithTitle:(NSString *)string value:(NSString *)param placeholder:(NSString *)string1;

@end
