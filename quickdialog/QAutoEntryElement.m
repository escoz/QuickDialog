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
#import "QAutoEntryElement.h"
#import "QuickDialog.h"

@implementation QAutoEntryElement

@synthesize textValue;
@synthesize placeholder;
@synthesize hiddenToolbar;
@synthesize autoCompleteValues = _autoCompleteValues;
@synthesize lastAutoComplete;
@synthesize autoCompleteColor;

@synthesize delegate = _delegate;

- (QAutoEntryElement *)init {
    self = [super init];
    if (self){
        self.autocapitalizationType = UITextAutocapitalizationTypeSentences;
        self.autocorrectionType = UITextAutocorrectionTypeDefault;
        self.keyboardType = UIKeyboardTypeDefault;
        self.keyboardAppearance = UIKeyboardAppearanceDefault;
        self.returnKeyType = UIReturnKeyDefault;
        self.enablesReturnKeyAutomatically = NO;
        self.secureTextEntry = NO;
    }
    return self;
}

- (QAutoEntryElement *)initWithTitle:(NSString *)string value:(NSString *)param placeholder:(NSString *)string1;
{
    self = [self init];
    if (self) {
        _title = string;
        textValue = param;
        placeholder = string1;
    }
    return self;
}


- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {
    
    QAutoEntryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuickformAutoEntryElement"];
    if (cell==nil){
        cell = [[QAutoEntryTableViewCell alloc] init];
    }

    [cell applyAppearanceForElement:self];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textField.enabled = self.enabled;
    cell.textField.userInteractionEnabled = self.enabled;
    cell.textField.textAlignment = self.appearance.entryAlignment;
    cell.imageView.image = self.image;
    [cell prepareForElement:self inTableView:tableView];
    return cell;
}

- (void)selected:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller indexPath:(NSIndexPath *)indexPath {
    if(self.enabled){
        [super selected:tableView controller:controller indexPath:indexPath];
    }
}

- (void)fetchValueIntoObject:(id)obj {
	if (_key==nil)
		return;
	
	[obj setValue:textValue forKey:_key];
}

- (NSString *)textField:(DOAutocompleteTextField *)textField completionForPrefix:(NSString *)prefix
{
    NSString* lowPrefix = [prefix lowercaseString];
    for (NSString *string in [textField getAutoCompletes])
    {
        NSString* strlower = [string lowercaseString];
        if([strlower hasPrefix:lowPrefix])
        {
            NSRange range = NSMakeRange(0,prefix.length);
            lastAutoComplete = string;
            return [string stringByReplacingCharactersInRange:range withString:@""];
        }
    }
    lastAutoComplete = @"";
    return @"";
}




#pragma mark - UITextInputTraits

@synthesize autocorrectionType = _autocorrectionType;
@synthesize autocapitalizationType = _autocapitalizationType;
@synthesize keyboardType = _keyboardType;
@synthesize keyboardAppearance = _keyboardAppearance;
@synthesize returnKeyType = _returnKeyType;
@synthesize enablesReturnKeyAutomatically = _enablesReturnKeyAutomatically;
@synthesize secureTextEntry = _secureTextEntry;

@end

