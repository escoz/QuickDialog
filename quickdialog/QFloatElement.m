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
@synthesize minimumValue = _minimumValue;
@synthesize maximumValue = _maximumValue;

- (QFloatElement *)initWithTitle:(NSString *)title value:(float)value {
    self = [super initWithTitle:title Value:nil] ;
    if (self) {
        _floatValue = value;
        _minimumValue = 0.0;
        _maximumValue = 1.0;
        self.enabled = YES;
    }
    return self;
}


- (QElement *)initWithValue:(float)value {
    self = [super init];
    if (self) {
        _floatValue = value;
        _minimumValue = 0.0;
        _maximumValue = 1.0;
        self.enabled = YES;
    }
    return self;
}

- (void)fetchValueIntoObject:(id)obj {
	if (_key==nil)
		return;
    [obj setValue:[NSNumber numberWithFloat:_floatValue] forKey:_key];
}

- (CGFloat)calculateSliderWidth:(QuickDialogTableView *)view cell:(UITableViewCell *)cell {
    CGFloat width = view.contentSize.width;
    if (_title==nil)
        width -= 40;
    else
        width -= [cell.textLabel.text sizeWithFont:[UIFont boldSystemFontOfSize:17]].width + 50;
    return width;
}

- (void)valueChanged:(UISlider *)slider {
   self.floatValue = slider.value;

    if (self.onValueChanged!=nil)
        self.onValueChanged(self);
}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {
    UITableViewCell *cell = [super getCellForTableView:tableView controller:controller];

    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, [self calculateSliderWidth:tableView cell:cell], 20)];
    [slider addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    slider.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    slider.minimumValue = _minimumValue;
    slider.maximumValue = _maximumValue;
    slider.value = _floatValue;
    cell.accessoryView = slider;
    return cell;
}

- (void)setNilValueForKey:(NSString *)key;
{
    if ([key isEqualToString:@"floatValue"]){
        self.floatValue = 0;
    }
    else {
        [super setNilValueForKey:key];
    }
}





@end
