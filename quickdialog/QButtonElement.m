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

@implementation QButtonElement
@synthesize enabled = _enabled;

- (QButtonElement *)init {
    self = [super init];
    if (self) {
        self.enabled = YES;
    }
    return self;
}

- (QButtonElement *)initWithTitle:(NSString *)title {
    self = [super initWithTitle:title value:nil];
    self.enabled = YES;
    return self;
}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuickformButtonElement"];
    if (cell == nil){
        cell= [[QTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"QuickformButtonElement"];
    }
    if (self.enabled) {
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        cell.textLabel.textColor = [UIColor colorWithRed:50.0f/255.0f green:79.0f/255.0f blue:133.0f/255.0f alpha:1];    
    } else {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textColor = [UIColor lightGrayColor];
    }
    
    cell.textLabel.text = _title;
    cell.textLabel.textAlignment = UITextAlignmentCenter;
    return cell;
}

- (void)selected:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller indexPath:(NSIndexPath *)indexPath {
    if (self.enabled) {
        [super selected:tableView controller:controller indexPath:indexPath];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end