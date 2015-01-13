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

#import "QBindingEvaluator.h"
#import "QRadioElement.h"
#import "QuickDialog.h"

@implementation QRadioElement {
    QSection *_internalRadioItemsSection;
}

@synthesize selected = _selected;
@synthesize values = _values;
@synthesize items = _items;
@synthesize itemsImageNames = _itemsImageNames;


- (void)createElements {
    _sections = nil;
    self.presentationMode = QPresentationModeNavigationInPopover;
    _internalRadioItemsSection = [[QSection alloc] init];

    [self addSection:_internalRadioItemsSection];

    for (NSUInteger i=0; i< [_items count]; i++){
        QRadioItemElement *element = [[QRadioItemElement alloc] initWithIndex:i RadioElement:self];
        element.imageNamed = [self.itemsImageNames objectAtIndex:i];
        element.title = [self.items objectAtIndex:i];
        [_internalRadioItemsSection addElement:element];
    }
}

-(void)setItems:(NSArray *)items {
    _items = items;
    [self createElements];
}

-(void)setItemsImageNames:(NSArray *)itemsImageNames {
    _itemsImageNames = itemsImageNames;
    if (self.items) {
        [self createElements];
    }
}

-(NSObject *)selectedValue {
    if (_selected<0 || _selected>=_values.count)
        return nil;

    return [_values objectAtIndex:(NSUInteger) _selected];
}

-(void)setSelectedValue:(NSObject *)aSelected {
    if ([aSelected isKindOfClass:[NSNumber class]]) {
        self.selected = [(NSNumber *)aSelected integerValue];
    } else {
        self.selected = [_values indexOfObject:aSelected];
    }

}

- (QEntryElement *)init {
    self = [super init];
    if (self) {
        _selected = -1;
    }

    return self;
}


- (QRadioElement *)initWithItems:(NSArray *)stringArray selected:(NSInteger)selected {
    self = [self initWithItems:stringArray selected:selected title:nil];
    _selected = selected;
    return self;
}


- (QRadioElement *)initWithDict:(NSDictionary *)valuesDictionary selected:(int)selected title:(NSString *)title {
    self = [self initWithItems:valuesDictionary.allKeys selected:(NSUInteger) selected];
    _values = valuesDictionary.allValues;
    _selected = selected;
    self.title = title;
    return self;
}


-(void)setSelectedItem:(id)item {
    if (self.items==nil || item==nil)
        return;
    self.selected = [self.items indexOfObject:item];
}

-(id)selectedItem {
    if (self.items == nil || [self.items count]<self.selected)
        return nil;

    return [self.items objectAtIndex:(NSUInteger) self.selected];
}

- (QRadioElement *)initWithItems:(NSArray *)stringArray selected:(NSInteger)selected title:(NSString *)title {
    self = [super init];
    if (self!=nil){
        self.items = stringArray;
        self.selected = selected;
        self.title = title;
    }
    return self;
}

- (void)selected:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller indexPath:(NSIndexPath *)path {
    if ((self.sections == nil) || !self.enabled){
        return;
    }

    [controller displayViewControllerForRoot:self];
}


- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {
    QEntryTableViewCell *cell = (QEntryTableViewCell *) [super getCellForTableView:tableView controller:controller];

    id selectedValue = nil;
    if (_selected >= 0 && _selected <_items.count){
        selectedValue = [_items objectAtIndex:(NSUInteger) _selected];
    }

    [self updateCell:cell selectedValue:selectedValue];
    cell.accessoryType = self.enabled ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
    cell.selectionStyle = self.enabled ? UITableViewCellSelectionStyleBlue : UITableViewCellSelectionStyleNone;
    cell.textField.userInteractionEnabled = NO;
    [cell setNeedsLayout];
    return cell;
}

- (void)updateCell:(QEntryTableViewCell *)cell selectedValue:(id)selectedValue {
    if (self.title == NULL){
        cell.textField.text = [selectedValue description];
        cell.detailTextLabel.text = nil;
        cell.textField.textAlignment = self.appearance.labelAlignment;
        cell.textField.textColor = self.enabled ? self.appearance.valueColorEnabled : self.appearance.valueColorDisabled;
    } else {
        cell.textLabel.text = _title;
        cell.textField.text = [selectedValue description];
        cell.textField.textAlignment = self.appearance.valueAlignment;
        cell.textField.textColor = self.enabled ? self.appearance.labelColorEnabled : self.appearance.labelColorDisabled;
        cell.detailTextLabel.textColor = self.enabled ? self.appearance.entryTextColorEnabled : self.appearance.entryTextColorDisabled;
    }
    cell.imageView.image = _image;
}

-(void)setSelected:(NSInteger)aSelected {
    _selected = aSelected;

    self.preselectedElementIndex = [NSIndexPath indexPathForRow:_selected inSection:0];

    if([_itemsImageNames objectAtIndex:(NSUInteger) self.selected] != nil) {
        self.image = [UIImage imageNamed:[_itemsImageNames objectAtIndex:(NSUInteger) self.selected]];
    }
    
    [self handleEditingChanged];
}

- (void)fetchValueIntoObject:(id)obj {
	if (_key==nil)	
		return;

    if (_selected < 0 || _selected >= (_values != nil ? _values : _items).count)
        return;

    if (_values==nil){
        [obj setValue:[NSNumber numberWithInteger:_selected] forKey:_key];
    } else {
        [obj setValue:[_values objectAtIndex:(NSUInteger) _selected] forKey:_key];
    }
}

- (BOOL)canTakeFocus {
    return NO;
}

@end
