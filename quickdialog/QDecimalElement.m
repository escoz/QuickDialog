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

#import "QEntryTableViewCell.h"
#import "QDecimalTableViewCell.h"
#import "QDecimalElement.h"

@implementation QDecimalElement {
    
@protected
    NSUInteger _fractionDigits;
}

@synthesize floatValue = _floatValue;
@synthesize fractionDigits = _fractionDigits;


- (QDecimalElement *)initWithTitle:(NSString *)title value:(float)value {
    self = [super initWithTitle:title Value:nil] ;
    _floatValue = value;
    return self;
}


- (QDecimalElement *)initWithValue:(float)value {
    self = [super init];
    _floatValue = value;
    return self;
}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {

    QDecimalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuickformDecimalElement"];
    if (cell==nil){
        cell = [[QDecimalTableViewCell alloc] init];
    }
    [cell prepareForElement:self inTableView:tableView];
    return cell;

}

- (void)fetchValueIntoObject:(id)obj {
	if (_key==nil)
		return;
    [obj setValue:[NSNumber numberWithFloat:_floatValue] forKey:_key];
}

@end