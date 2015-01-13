// created by Iain Stubbs but based on QEntryTableViewCell.m
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

#import "QAutoEntryTableViewCell.h"
#import "QuickDialog.h"

@implementation QAutoEntryTableViewCell {
    NSString *_lastFullStringWithAutocompletion;
    QAutoEntryElement *_autoEntryElement;
    BOOL _autoCompleteEnabled;
}

@synthesize autoCompleteField = _autoCompleteField;
@synthesize autoCompleteValues;
@synthesize lastFullStringWithAutocompletion = _lastFullStringWithAutocompletion;


- (void)createSubviews {
    _autoCompleteField = [[DOAutocompleteTextField alloc] init];
    _autoCompleteField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _autoCompleteField.borderStyle = UITextBorderStyleNone;
    _autoCompleteField.delegate = self;
    _autoCompleteField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _autoCompleteField.autoresizingMask = ( UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    [_autoCompleteField addTarget:self action:@selector(textFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.contentView addSubview:_autoCompleteField];
    [self setNeedsLayout];
}

- (QAutoEntryTableViewCell *)init {
    self = [self initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"QuickformAutoEntryElement"];
    if (self!=nil){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self createSubviews];
    }
    return self;
}


- (void)prepareForElement:(QEntryElement *)element inTableView:(QuickDialogTableView *)tableView{
    _quickformTableView = tableView;
    _autoCompleteField.delegate = self;

    _entryElement = element;
    _autoEntryElement = (QAutoEntryElement *)element;

    self.textLabel.text = _entryElement.title;
    self.autoCompleteValues = _autoEntryElement.autoCompleteValues;
    _autoCompleteField.text = _autoEntryElement.textValue;
    _autoCompleteField.placeholder = _autoEntryElement.placeholder;
    _autoCompleteField.autocapitalizationType = _autoEntryElement.autocapitalizationType;
    _autoCompleteField.autocorrectionType = _autoEntryElement.autocorrectionType;
    _autoCompleteField.keyboardType = _autoEntryElement.keyboardType;
    _autoCompleteField.keyboardAppearance = _autoEntryElement.keyboardAppearance;
    _autoCompleteField.secureTextEntry = _autoEntryElement.secureTextEntry;
    _autoCompleteField.autocompleteTextColor = _autoEntryElement.autoCompleteColor;
    _autoCompleteField.returnKeyType = _autoEntryElement.returnKeyType;
    _autoCompleteField.enablesReturnKeyAutomatically = _autoEntryElement.enablesReturnKeyAutomatically;
    
    if (_autoEntryElement.hiddenToolbar){
        _autoCompleteField.inputAccessoryView = nil;
    } else {
        _autoCompleteField.inputAccessoryView = [self createActionBar];
    }

    _autoCompleteField.userInteractionEnabled = element.enabled;

    [self updatePrevNextStatus];
}

- (BOOL)handleActionBarDone:(UIBarButtonItem *)doneButton {
    [_autoCompleteField resignFirstResponder];
    return [super handleActionBarDone:doneButton];
}


-(void)recalculateEntryFieldPosition {
    _entryElement.parentSection.entryPosition = CGRectZero;
    _autoCompleteField.frame = [self calculateFrameForEntryElement];
    CGRect labelFrame = self.textLabel.frame;
    self.textLabel.frame = CGRectMake(labelFrame.origin.x, labelFrame.origin.y,
            _entryElement.parentSection.entryPosition.origin.x-20, labelFrame.size.height);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self recalculateEntryFieldPosition];
}

- (void)prepareForReuse {
    _quickformTableView = nil;
    _entryElement = nil;
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    if (_autoCompleteEnabled && ![_entryElement.textValue isEqualToString:self.lastFullStringWithAutocompletion]) {
        _autoCompleteField.text = self.lastFullStringWithAutocompletion;
        // In an AutoEntryElement, a DidEndEditing event might actually be a
        // change to the text value.  This is because it is an implicit acceptance
        // of the displayed auto-chosen value.
        _entryElement.textValue = _autoCompleteField.text;
        [_entryElement handleEditingChanged];
    }
}

- (void)textFieldEditingChanged:(UITextField *)textField {
    _autoCompleteEnabled = YES;
    _entryElement.textValue = _autoCompleteField.text;
    [_entryElement handleEditingChanged];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    BOOL previousAutoCompleteEnabledValue = _autoCompleteEnabled;
    _autoCompleteEnabled = NO;
    BOOL result = [super textFieldShouldReturn:textField];
    [textField resignFirstResponder];
    _autoCompleteEnabled = previousAutoCompleteEnabledValue;
    return result;
}
- (BOOL)becomeFirstResponder {
    _autoCompleteEnabled = NO;
    [_autoCompleteField becomeFirstResponder];
    return YES;
}

#pragma mark - DOAutocompleteTextFieldDelegate
- (NSString *)textField:(DOAutocompleteTextField *)textField completionForPrefix:(NSString *)prefix
{
    if (!prefix || !_autoCompleteEnabled) {
        return nil;
    }
    
    NSString* lowPrefix = [prefix lowercaseString];
    
    for (NSString *string in autoCompleteValues)
    {
        NSString* strlower = [string lowercaseString];
        if([strlower hasPrefix:lowPrefix])
        {
            NSRange range = NSMakeRange(0,prefix.length);
            _lastFullStringWithAutocompletion = string;
            return [string stringByReplacingCharactersInRange:range withString:@""];
        }
    }
    
    // If we have got here, there is no auto-completion available.  
    // We want to allow the user to save this string, so the
    // last full string with auto-completion is == the string the user has
    // entered.
    _lastFullStringWithAutocompletion = prefix;
    
    // Return null string to indicate no autocompletion possible
    return @"";
}

@end
