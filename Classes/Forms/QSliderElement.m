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

#import "QSliderElement.h"
#import "QSliderTableViewCell.h"

@implementation QSliderElement


- (instancetype)init {
    self = [super init];
    if (self!=nil)
    {
        self.cellClass = [QSliderTableViewCell class];
        self.enabled = YES;
        self.minimumValue = 0.0;
        self.maximumValue = 1.0;
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title value:(float)value {
    self = [self init] ;
    if (self) {
        self.title = title;
        self.floatValue = value;
    }
    return self;
}


- (void)fetchValueIntoObject:(id)obj {
	if (_key==nil)
		return;
    [obj setValue:@(_floatValue) forKey:_key];
}

- (void)valueChanged:(UISlider *)slider {
    self.floatValue = slider.value;

    [self handleEditingChanged];
}

- (void)setCurrentCell:(UITableViewCell *)currentCell
{
    super.currentCell = currentCell;
    QSliderTableViewCell *cell = (QSliderTableViewCell *) currentCell;
    [cell.slider addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    cell.slider.minimumValue = self.minimumValue;
    cell.slider.maximumValue = self.maximumValue;
    cell.slider.value = self.floatValue;
    
    cell.textLabel.text = _title;
    cell.detailTextLabel.text = [_value description];
    cell.imageView.image = _image;
    cell.accessoryType = self.accessoryType != UITableViewCellAccessoryNone ? self.accessoryType : ( self.sections!= nil || self.controllerAction!=nil ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone);
    cell.selectionStyle = self.sections!= nil || self.controllerAction!=nil ? UITableViewCellSelectionStyleBlue: UITableViewCellSelectionStyleNone;
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
