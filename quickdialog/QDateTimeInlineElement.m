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

#import "QDateEntryTableViewCell.h"

@implementation QDateTimeInlineElement {
@private
    NSDate *_maximumDate;
    NSDate *_minimumDate;


}

@synthesize dateValue = _dateValue;
@synthesize mode = _mode;
@synthesize centerLabel = _centerLabel;
@synthesize maximumDate = _maximumDate;
@synthesize minimumDate = _minimumDate;


- (QDateTimeInlineElement *)init {
    self = [super init];
    _dateValue = [NSDate date];
    return self;
}

- (QDateTimeInlineElement *)initWithKey:(NSString *)key {
    self = [super initWithKey:key];
    _dateValue = [NSDate date];
    return self;
}

- (QDateTimeInlineElement *)initWithTitle:(NSString *)string date:(NSDate *)date {
    self = [super initWithTitle:string value:[date description]];
    if (self!=nil){
        _dateValue = date;
        _mode = UIDatePickerModeDateAndTime;
    }
    return self;
}


- (void)setTicksValue:(NSNumber *)ticks {
    self.dateValue = [NSDate dateWithTimeIntervalSince1970:ticks.doubleValue];
}

-(NSNumber *)ticksValue {
    return [NSNumber numberWithDouble:[self.dateValue timeIntervalSince1970]];
}

- (QDateTimeInlineElement *)initWithDate:(NSDate *)date {
    return [self initWithTitle:nil date:date];
}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {

    QDateEntryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuickformDateTimeInlineElement"];
    if (cell==nil){
        cell = [[QDateEntryTableViewCell alloc] init];
    }
    [cell prepareForElement:self inTableView:tableView];
    cell.imageView.image = self.image;
    cell.selectionStyle = UITableViewCellSelectionStyleBlue ;
    return cell;

}

- (void)fetchValueIntoObject:(id)obj {
	if (_key==nil)
		return;
    [obj setValue:_dateValue forKey:_key];
}

@end