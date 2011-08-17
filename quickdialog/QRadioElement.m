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

#import "QRootElement.h"
#import "QRadioElement.h"
#import "QSection.h"
#import "QLabelElement.h"
#import "QRadioItemElement.h"


@interface QRadioElement ()

@end

@implementation QRadioElement

@synthesize selected = _selected;

- (void)createElements {
    _sections = nil;
    _parentSection = [[QSection alloc] init];
    
    [self addSection:_parentSection];

    for (NSUInteger i=0; i< [_items count]; i++){
        [_parentSection addElement:[[QRadioItemElement alloc] initWithIndex:i RadioElement:self]];
    }
}

- (NSArray *)items {
    return _items;
}

- (QRadioElement *)initWithItems:(NSArray *)stringArray selected:(NSUInteger)selected {
    self = [self initWithItems:stringArray selected:selected title:nil];
    return self;
}

- (QRadioElement *)initWithItems:(NSArray *)stringArray selected:(NSUInteger)selected title:(NSString *)title {
    self = [super init];
    if (self!=nil){
        _items = stringArray;
        _selected = selected;
        [self createElements];
        self.title = title;
    }
    return self;
}


- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {
    UITableViewCell *cell = [super getCellForTableView:tableView controller:controller];

    if (self.title == NULL){
        cell.textLabel.text = [[_items objectAtIndex:_selected] description];
        cell.detailTextLabel.text = nil;
        cell.imageView.image = nil;
    } else {
        cell.textLabel.text = _title;
        cell.detailTextLabel.text = [[_items objectAtIndex:_selected] description];
        cell.imageView.image = nil;
    }
    return cell;
}

- (void)fetchValueIntoObject:(id)obj {
	if (_key==nil)	
		return;
    [obj setObject:[NSNumber numberWithInt:_selected] forKey:_key];
}



@end