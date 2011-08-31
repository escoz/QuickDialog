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

#import "QFloatElement.h"

@implementation QFloatElement

@synthesize floatValue = _floatValue;

- (QFloatElement *)initWithTitle:(NSString *)title value:(float)value {
    self = [super initWithTitle:title Value:nil] ;
    _floatValue = value;
    return self;
}


- (QElement *)initWithValue:(float)value {
    self = [super init];
    _floatValue = value;

    return self;
}

- (void)fetchValueIntoObject:(id)obj {
	if (_key==nil)
		return;
    [obj setValue:[NSNumber numberWithFloat:_floatValue] forKey:_key];
}

- (CGFloat)calculateSliderWidth:(QuickDialogTableView *)view cell:(UITableViewCell *)cell {
    if (_title==nil)
        return view.contentSize.width-40;

    return view.contentSize.width - [cell.textLabel.text sizeWithFont:[UIFont boldSystemFontOfSize:17]].width - 50;
}

- (void)valueChanged:(UISlider *)slider {
   _floatValue = slider.value;
}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {
    UITableViewCell *cell = [super getCellForTableView:tableView controller:controller];

    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, [self calculateSliderWidth:tableView cell:cell], 20)];
    [slider addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];

    slider.value = _floatValue;
    cell.accessoryView = slider;
    return cell;
}





@end