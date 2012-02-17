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

@implementation QAutoEntryTableViewCell {
    NSString *_lastAutoComplete;
}

@synthesize autoCompleteField = _autoCompleteField;
@synthesize autoCompleteValues;
@synthesize lastAutoComplete = _lastAutoComplete;


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
    self = [self initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"QuickformEntryElement"];
    if (self!=nil){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self createSubviews];
    }
    return self;
}

- (void)prepareForElement:(QEntryElement *)element inTableView:(QuickDialogTableView *)tableView{
    entryElement = (QAutoEntryElement *)element;

    self.textLabel.text = element.title;
    self.autoCompleteValues = entryElement.autoCompleteValues;

    _quickformTableView = tableView;
    _textField.delegate = self;

    _autoCompleteField.text = entryElement.textValue;
    _autoCompleteField.placeholder = entryElement.placeholder;
    _autoCompleteField.autocapitalizationType = entryElement.autocapitalizationType;
    _autoCompleteField.autocorrectionType = entryElement.autocorrectionType;
    _autoCompleteField.keyboardType = entryElement.keyboardType;
    _autoCompleteField.keyboardAppearance = entryElement.keyboardAppearance;
    _autoCompleteField.secureTextEntry = entryElement.secureTextEntry;
    _autoCompleteField.autocompleteTextColor = entryElement.autoCompleteColor;
    _autoCompleteField.returnKeyType = entryElement.returnKeyType;
    _autoCompleteField.enablesReturnKeyAutomatically = entryElement.enablesReturnKeyAutomatically;
    
    if (entryElement.hiddenToolbar){
        _autoCompleteField.inputAccessoryView = nil;
    } else {
        _autoCompleteField.inputAccessoryView = [self createActionBar];
    }

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
    entryElement = nil;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    BOOL result = [super textFieldShouldReturn:textField];
    textField.text = self.lastAutoComplete;
    [textField resignFirstResponder];
    return result;
}
- (BOOL)becomeFirstResponder {
    [_autoCompleteField becomeFirstResponder];
    return YES;
}


#pragma mark - DOAutocompleteTextFieldDelegate
- (NSString *)textField:(DOAutocompleteTextField *)textField completionForPrefix:(NSString *)prefix
{
    NSString* lowPrefix = [prefix lowercaseString];
    
    for (NSString *string in autoCompleteValues)
    {
        NSString* strlower = [string lowercaseString];
        if([strlower hasPrefix:lowPrefix])
        {
            NSRange range = NSMakeRange(0,prefix.length);
            _lastAutoComplete = string;
            return [string stringByReplacingCharactersInRange:range withString:@""];
        }
    }
    _lastAutoComplete = @"";
    return @"";
}

@end