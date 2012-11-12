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

@implementation QMultilineElement

@synthesize delegate = _delegate;


- (QEntryElement *)init {
    self = [super init];
    if (self) {
        self.presentationMode = QPresentationModePopover;
    }

    return self;
}

- (QMultilineElement *)initWithTitle:(NSString *)title value:(NSString *)text
{
    if ((self = [super initWithTitle:title Value:nil])) {
        self.textValue = text;
        self.presentationMode = QPresentationModePopover;
    }
    return self;
}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {
    QEntryTableViewCell *cell = (QEntryTableViewCell *) [super getCellForTableView:tableView controller:controller];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    cell.textField.enabled = NO;
    return cell;
}


- (void)selected:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller indexPath:(NSIndexPath *)indexPath
{
    __block QMultilineTextViewController *textController = [[QMultilineTextViewController alloc] initWithTitle:self.title];
    textController.entryElement = self;
    textController.entryCell = (QEntryTableViewCell *) [tableView cellForElement:self];
    textController.resizeWhenKeyboardPresented = YES;
    textController.textView.text = self.textValue;
    textController.textView.autocapitalizationType = self.autocapitalizationType;
    textController.textView.autocorrectionType = self.autocorrectionType;
    textController.textView.keyboardAppearance = self.keyboardAppearance;
    textController.textView.keyboardType = self.keyboardType;
    textController.textView.secureTextEntry = self.secureTextEntry;
    textController.textView.autocapitalizationType = self.autocapitalizationType;
    textController.textView.returnKeyType = self.returnKeyType;

    __block QMultilineElement *weakSelf = self;
    textController.willDisappearCallback = ^ {
        weakSelf.textValue = textController.textView.text;
        [[tableView cellForElement:weakSelf] setNeedsDisplay];
    };
    [controller displayViewControllerInPopover:textController withNavigation:NO];
}

- (void)fetchValueIntoObject:(id)obj
{
	if (_key == nil) {
		return;
	}
	[obj setValue:self.textValue forKey:_key];
}

- (BOOL)canTakeFocus {
    return NO;
}

@end
