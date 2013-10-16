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
#import "QEntryTableViewCell.h"
#import "NSStringMask.h"

@protocol QuickDialogEntryElementDelegate;

/**
  QEntryElement: input field to allow you to collect values from the user. Automatically resizes so that all entries in the same sections look alike.
*/

@interface QEntryElement : QLabelElement <UITextInputTraits> {

@private
    NSString *_placeholder;
    NSString *_textValue;

    BOOL _hiddenToolbar;
}

@property (nonatomic, strong) NSString *textValue;
@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, strong) NSString *prefix;
@property (nonatomic, strong) NSString *suffix;
@property (nonatomic, strong) NSString *mask;
@property (atomic, assign) int maxLength;
@property (assign) BOOL hiddenToolbar;

@property(nonatomic, unsafe_unretained) id<QuickDialogEntryElementDelegate> delegate;

@property(nonatomic) UITextAutocapitalizationType autocapitalizationType; // default is UITextAutocapitalizationTypeSentences
@property(nonatomic) UITextAutocorrectionType autocorrectionType;         // default is UITextAutocorrectionTypeDefault
@property(nonatomic) UIKeyboardType keyboardType;                         // default is UIKeyboardTypeDefault
@property(nonatomic) UIKeyboardAppearance keyboardAppearance;             // default is UIKeyboardAppearanceDefault
@property(nonatomic) UIReturnKeyType returnKeyType;                       // default is UIReturnKeyDefault (See note under UIReturnKeyType enum)
@property(nonatomic) BOOL enablesReturnKeyAutomatically;                  // default is NO (when YES, will automatically disable return key when text widget has zero-length contents, and will automatically enable when text widget has non-zero-length contents)
@property(nonatomic,getter=isSecureTextEntry) BOOL secureTextEntry;       // default is NO
@property(nonatomic, assign) BOOL clearsOnBeginEditing;                   // default is NO

@property(nonatomic, copy) NSString *customDateFormat;

- (QEntryElement *)init;
- (QEntryElement *)initWithTitle:(NSString *)string Value:(NSString *)param Placeholder:(NSString *)string1;

- (BOOL)canTakeFocus;

- (void) fieldDidEndEditing;

- (void)handleEditingChanged:(QEntryTableViewCell *)cell;

@end
