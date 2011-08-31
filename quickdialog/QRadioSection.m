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

#import "QuickDialogTableView.h"
#import "QRadioSection.h"
#import "QRootElement.h"
#import "QRadioItemElement.h"

@implementation QRadioSection

@synthesize selected = _selected;


- (void)createElements {

    for (NSUInteger i=0; i< [_items count]; i++){
        [self addElement:[[QRadioItemElement alloc] initWithIndex:i RadioSection:self]];
    }
}

- (NSArray *)items {
    return _items;
}

- (void)setItems:(NSArray *)items {
    _items = items;
    self.elements = nil;
    [self createElements];
}

- (QRadioSection *)initWithItems:(NSArray *)stringArray selected:(NSUInteger)selected {
    self = [super init];
    if (self!=nil){
        _items = stringArray;
        _selected = selected;
        [self createElements];
    }
    return self;
}

- (QRadioSection *)initWithItems:(NSArray *)stringArray selected:(NSUInteger)selected title:(NSString *)title {
    self = [self initWithItems:stringArray selected:selected];
    self.title = title;
    return self;
}

- (void)fetchValueIntoObject:(id)obj {
    if (_key==nil)
		return;
    [obj setValue:[NSNumber numberWithInteger:_selected] forKey:_key];
}


@end