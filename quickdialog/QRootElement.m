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
#import "QRootElement.h"
#import "QuickDialog.h"
#import "QEntryElement.h"

@implementation QRootElement {
@private
    NSDictionary *_sectionTemplate;
    QPresentationMode _presentationMode;
}


@synthesize title = _title;
@synthesize sections = _sections;
@synthesize grouped = _grouped;
@synthesize controllerName = _controllerName;
@synthesize sectionTemplate = _sectionTemplate;
@synthesize emptyMessage = _emptyMessage;
@synthesize onValueChanged = _onValueChanged;
@synthesize presentationMode = _presentationMode;
@synthesize preselectedElementIndex = _preselectedElementIndex;


- (instancetype)init {
    self = [super init];
    return self;

}
- (void)addSection:(QSection *)section {
    if (_sections==nil)
        _sections = [[NSMutableArray alloc] init];

    [_sections addObject:section];
    section.rootElement = self;
}

- (void)setSections:(NSMutableArray *)sections
{
    _sections = nil;
    for (QSection *section in sections){
        [self addSection:section];
    }
}


+ (instancetype)rootForJSON:(NSString *)jsonFileName withObject:(id)object {
    QRootElement *root = [self rootForJSON:jsonFileName];
    root.object = object;
    return root;
}

- (QSection *)getSectionForIndex:(NSInteger)index {
   return [_sections objectAtIndex:(NSUInteger) index];
}

- (NSInteger)numberOfSections {
    return [_sections count];
}

- (QSection *)getVisibleSectionForIndex:(NSInteger)index
{
    for (QSection * q in _sections)
    {
        if (!q.hidden && index-- == 0)
            return q;
    }
    return nil;
}
- (NSInteger)visibleNumberOfSections
{
    NSUInteger c = 0;
    for (QSection * q in _sections)
    {
        if (!q.hidden)
            c++;
    }
    return c;
}
- (NSUInteger)getVisibleIndexForSection: (QSection*)section
{
    NSUInteger c = 0;
    for (QSection * q in _sections)
    {
        if (q == section)
            return c;
        if (!q.hidden)
            ++c;
    }
    return NSNotFound;
}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {
    UITableViewCell *cell = [super getCellForTableView:tableView controller:controller];
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    if (_title!= nil)
        cell.textLabel.text = [NSString stringWithFormat:@"%@", _title];
    return cell;
}

- (void)selected:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller indexPath:(NSIndexPath *)path {
    [super selected:tableView controller:controller indexPath:path];

    if (self.sections==nil)
            return;

    [controller displayViewControllerForRoot:self];
}

- (void)handleEditingChanged
{    
    if(self.onValueChanged) {
        self.onValueChanged(self);
    }
}

- (void)fetchValueIntoObject:(id)obj {
    for (QSection *s in _sections){
        [s fetchValueIntoObject:obj];

    }
}

- (void)fetchValueUsingBindingsIntoObject:(id)obj {
    [super fetchValueUsingBindingsIntoObject:obj];
    for (QSection *s in _sections){
        [s fetchValueUsingBindingsIntoObject:obj];
    }
}

- (void)bindToObject:(id)data shallow:(BOOL)shallow
{
    if (!shallow) {
        if ([self.bind length]==0 || [self.bind rangeOfString:@"iterate"].location == NSNotFound)  {
            for (QSection *sections in self.sections) {
                [sections bindToObject:data];
            }
        } else {
            [self.sections removeAllObjects];
        }
    }

    [[QBindingEvaluator new] bindObject:self toData:data];
}

- (void)bindToObject:(id)data {
    [self bindToObject:data shallow:NO];
}

-(void)dealloc {
    for (QSection * section in self.sections) {
        section.rootElement = nil;
    }
}

- (QSection *)sectionWithKey:(NSString *)key
{
    for (QSection *section in _sections) {
        if ([section.key isEqualToString:key]) {
            return section;
        }
    }
    return nil;
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

- (QRootElement *)rootWithKey:(NSString *)string {
    return (QRootElement *) [self elementWithKey:string];

}


- (QEntryElement *)findElementToFocusOnBefore:(QElement *)previous {

    QEntryElement *previousElement = nil;
    for (QSection *section in self.sections) {
        for (QElement *e in section.elements) {
            if (e == previous) {
                return previousElement;
            }
            else if ([e isKindOfClass:[QEntryElement class]] && [(QEntryElement *)e canTakeFocus]) {
                previousElement = (QEntryElement *)e;
            }
        }
    }
    return nil;
}

- (QEntryElement *)findElementToFocusOnAfter:(QElement *)element {

    BOOL foundSelf = element == nil;
    for (QSection *section in self.sections) {
        for (QElement *e in section.elements) {
            if (e == element) {
                foundSelf = YES;
            }
            else if (foundSelf && [e isKindOfClass:[QEntryElement class]] && [(QEntryElement *)e canTakeFocus]) {
                return (QEntryElement *) e;
            }
        }
    }
    return nil;
}


@end
