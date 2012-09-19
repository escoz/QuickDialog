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

#import <objc/message.h>

@implementation QSegmentedElement {
    __unsafe_unretained QuickDialogController *_controller;
}

@synthesize selected = _selected;
@synthesize values = _values;
@synthesize items = _items;

- (QSegmentedElement *)initWithDict:(NSDictionary *)valuesDictionary selected:(int)selected title:(NSString *)title {
    self = [self initWithItems:valuesDictionary.allKeys selected:(NSUInteger) selected];
    _values = valuesDictionary.allValues;
    self.title = title;
    return self;
}


- (QSegmentedElement *)initWithItems:(NSArray *)stringArray selected:(NSInteger)selected {
    self = [self initWithItems:stringArray selected:selected title:nil];
    return self;
}

- (QSegmentedElement *)initWithItems:(NSArray *)stringArray selected:(NSInteger)selected title:(NSString *)title {
    self = [super init];
    if (self!=nil){
        self.items = stringArray;
        self.selected = selected;
        self.title = title;
    }
    return self;
}


- (void)selected:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller indexPath:(NSIndexPath *)path {
    return;
}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {
    UITableViewCell *cell = [super getCellForTableView:tableView controller:controller];
    _controller = controller;

    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:self.items];
    segmentedControl.frame = CGRectMake(0, 0, segmentedControl.frame.size.width, 34);
    
    UIFont *font = [UIFont boldSystemFontOfSize:12.0f];
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font
                                                           forKey:UITextAttributeFont];
    [segmentedControl setTitleTextAttributes:attributes
                                    forState:UIControlStateNormal];

    segmentedControl.selectedSegmentIndex = self.selected;

    [segmentedControl addTarget:self action:@selector(switched:) forControlEvents:UIControlEventValueChanged];
    cell.accessoryView = segmentedControl;

    return cell;
}

-(void)setSelectedItem:(id)item {
    if (self.items==nil)
        return;
    self.selected = [self.items indexOfObject:item];
}

-(id)selectedItem {
    if (self.items == nil || [self.items count]<self.selected)
        return nil;
    
    return [self.items objectAtIndex:(NSUInteger) self.selected];
}

-(NSObject *)selectedValue {    
    return [_values objectAtIndex:(NSUInteger) _selected];
}

-(void)setSelectedValue:(NSObject *)aSelected {
    if ([aSelected isKindOfClass:[NSNumber class]]) {
        _selected = [(NSNumber *)aSelected integerValue];
    } else {
        _selected = [_values indexOfObject:aSelected];
    }
}

- (void)switched:(id)sender {
    UISegmentedControl *segment=(UISegmentedControl*)sender;

    _selected = segment.selectedSegmentIndex;
    
    if ((_controller != nil && self.controllerAction != nil) || _onSelected != nil) {
        [self handleElementSelected:_controller];
    }
}

- (void)fetchValueIntoObject:(id)obj {
	if (_key==nil)
		return;
    [obj setValue:self.selectedValue forKey:_key];
}


@end