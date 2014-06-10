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

#import "QEntryElement.h"
#import "QuickDialog.h"

@implementation QEntryElement

- (instancetype)init {
    self = [super init];
    if (self){
        self.autocapitalizationType = UITextAutocapitalizationTypeSentences;
        self.autocorrectionType = UITextAutocorrectionTypeDefault;
        self.keyboardType = UIKeyboardTypeDefault;
        self.keyboardAppearance = UIKeyboardAppearanceDefault;
        self.returnKeyType = UIReturnKeyDefault;
        self.enablesReturnKeyAutomatically = NO;
        self.secureTextEntry = NO;
        self.maxLength = 0;

        self.cellClass = [QEntryTableViewCell class];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title value:(NSString *)value placeholder:(NSString *)placeholder
{
    QEntryElement *element = [self init];
    if (element!=nil) {
        self.title = title;
        self.value = value;
        self.placeholder = placeholder;
    }
    return element;
}


- (void)setCurrentCell:(UITableViewCell *)qCell
{
    super.currentCell = qCell;

    QEntryTableViewCell *cell = (QEntryTableViewCell *) qCell;
    cell.textField.text = [self.value description];
    cell.textField.placeholder = self.placeholder;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textField.enabled = self.enabled;
    cell.textField.userInteractionEnabled = self.enabled;
    cell.imageView.image = self.image;
}


- (void)selected:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller indexPath:(NSIndexPath *)indexPath {
    [super selected:tableView controller:controller indexPath:indexPath];
}

- (void) fieldDidEndEditing
{
    [self performAction];
}

- (void)fetchValueIntoObject:(id)obj {
	if (_key==nil)
		return;
	
	[obj setValue:_textValue forKey:_key];
}

- (BOOL)canTakeFocus {
    return self.enabled && !self.hidden;
}

- (void)handleEditingChanged:(QEntryTableViewCell *)cell
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(QEntryEditingChangedForElement:andCell:)]){
        [self.delegate QEntryEditingChangedForElement:self andCell:cell];
    }

    [self handleEditingChanged];
}

#pragma mark - UITextInputTraits

@synthesize autocapitalizationType = _autocapitalizationType;
@synthesize keyboardType = _keyboardType;
@synthesize keyboardAppearance = _keyboardAppearance;
@synthesize returnKeyType = _returnKeyType;
@synthesize enablesReturnKeyAutomatically = _enablesReturnKeyAutomatically;
@synthesize secureTextEntry = _secureTextEntry;
@synthesize clearsOnBeginEditing = _clearsOnBeginEditing;
@synthesize customDateFormat = _customDateFormat;


@end
