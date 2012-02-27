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

@implementation QRootElement

@synthesize title = _title;
@synthesize sections = _sections;
@synthesize grouped = _grouped;
@synthesize controllerName = _controllerName;

- (QRootElement *)init {
    self = [super init];
    return self;
}
- (void)addSection:(QSection *)section {
    if (_sections==nil)
        _sections = [[NSMutableArray alloc] init];

    [_sections addObject:section];
    section.rootElement = self;
}

- (QSection *)getSectionForIndex:(NSInteger)index {
   return [_sections objectAtIndex:(NSUInteger) index];
}

- (NSInteger)numberOfSections {
    return [_sections count];
}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {
    UITableViewCell *cell = [super getCellForTableView:tableView controller:controller];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    cell.textLabel.text = _title;
    return cell;
}

- (void)selected:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller indexPath:(NSIndexPath *)path {
    [super selected:tableView controller:controller indexPath:path];

    if (self.sections==nil)
            return;

    [controller displayViewControllerForRoot:self];
}

- (void)fetchValueIntoObject:(id)obj {
    for (QSection *s in _sections){
        [s fetchValueIntoObject:obj];

    }
}

- (void)bindToObject:(id)obj {
    for (QSection *s in _sections){
        [s bindToObject:obj];
    }
    [super bindToObject:obj];

}

-(void)dealloc {
    for (QSection * section in self.sections) {
        section.rootElement = nil;
    }
}


- (QElement *)elementWithKey:(NSString *)elementKey {
    for (QSection *s in _sections){
        for (QElement *el in s.elements) {
            if ([elementKey isEqualToString:el.key])
                return el;
            if ([el isKindOfClass:[QRootElement class]]){
                QElement *subElement = [((QRootElement *)el) elementWithKey:elementKey];
                if (subElement!=nil)
                    return subElement;
            }
        }
    }
    return nil;
}
@end