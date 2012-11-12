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

#import "QSection.h"
#import "QSortingSection.h"
#import "QElement.h"

@implementation QSortingSection {

}

@synthesize canDeleteRows = _canDeleteRows;
@synthesize canReorderRows = _canReorderRows;


- (QSortingSection *)init {
    self = [super init];
    _canDeleteRows = NO;
    _canReorderRows = NO;
    return self;
}

- (BOOL)needsEditing {
    return _canDeleteRows || _canReorderRows;
}

- (void)fetchValueIntoObject:(id)obj {
    if (_key == nil)
       return;

    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (QElement *el in self.elements){
        [result addObject:el.key];
    }
    [obj setValue:result forKey:_key];
}


- (void)moveElementFromRow:(NSUInteger)from toRow:(NSUInteger)to
{
    from = [self.elements indexOfObject:[self getVisibleElementForIndex:from]];
    to   = [self.elements indexOfObject:[self getVisibleElementForIndex:to]];
    [self.elements moveObjectFromIndex:from toIndex:to];
}
- (void)removeElementForRow:(NSUInteger)row
{
    row = [self.elements indexOfObject:[self getVisibleElementForIndex:row]];
    [self.elements removeObjectAtIndex:row];
}
- (BOOL)canMoveElementForRow:(NSUInteger)row
{
    row = [self.elements indexOfObject:[self getVisibleElementForIndex:row]];
    return row >= self.beforeTemplateElements.count && self.elements.count - self.afterTemplateElements.count > row;
}
- (BOOL)canRemoveElementForRow:(NSUInteger)row
{
    row = [self.elements indexOfObject:[self getVisibleElementForIndex:row]];
    return row >= self.beforeTemplateElements.count && self.elements.count - self.afterTemplateElements.count > row;
}

@end