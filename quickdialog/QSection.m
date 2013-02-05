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
#import "QSection.h"
#import "QuickDialog.h"

@implementation QSection {
@private
    id _object;
    NSString *_headerImage;
    NSString *_footerImage;
    NSDictionary *_elementTemplate;
    BOOL _canDeleteRows;
    NSMutableArray *_afterTemplateElements;
    NSMutableArray *_beforeTemplateElements;
}
@synthesize title;
@synthesize footer;
@synthesize elements;
@synthesize rootElement = _rootElement;
@synthesize key = _key;
@synthesize bind = _bind;
@synthesize headerView = _headerView;
@synthesize footerView = _footerView;
@synthesize entryPosition = _entryPosition;
@synthesize headerImage = _headerImage;
@synthesize footerImage = _footerImage;
@synthesize elementTemplate = _elementTemplate;
@synthesize canDeleteRows = _canDeleteRows;
@synthesize afterTemplateElements = _afterTemplateElements;
@synthesize beforeTemplateElements = _beforeTemplateElements;

@synthesize hidden = _hidden;
@dynamic visibleIndex;
@synthesize object = _object;


- (QElement *)getVisibleElementForIndex:(NSInteger)index
{
    for (QElement * q in self.elements)
    {
        if (!q.hidden && index-- == 0)
            return q;
    }
    return nil;
}
- (NSInteger)visibleNumberOfElements
{
    NSUInteger c = 0;
    for (QElement * q in self.elements)
    {
        if (!q.hidden)
            c++;
    }
    return c;
}

- (NSUInteger)getVisibleIndexForElement:(QElement*)element
{
    NSUInteger c = 0;
    for (QElement * q in self.elements)
    {
        if (q == element)
            return c;
        if (!q.hidden)
            ++c;
    }
    return NSNotFound;
}

- (NSUInteger) visibleIndex
{
    return [self.rootElement getVisibleIndexForSection:self];
}

- (BOOL)needsEditing {
    return NO;
}

- (void)setFooterImage:(NSString *)imageName {
    _footerImage = imageName;
    self.footerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_footerImage]];
    self.footerView.contentMode = UIViewContentModeCenter;
}

- (void)setHeaderImage:(NSString *)imageName {
    _headerImage = imageName;
    self.headerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_headerImage]];
    self.headerView.contentMode = UIViewContentModeCenter;
}

- (QSection *)initWithTitle:(NSString *)sectionTitle {
    self = [super init];
    if (self) {
        self.title = sectionTitle;
    }
    return self;
}

- (void)addElement:(QElement *)element
{
    if (self.elements == nil) {
        self.elements = [NSMutableArray array];
    }
    
    element.parentSection = self;
    [self.elements addObject:element];
}

- (void)insertElement:(QElement *)element atIndex:(NSUInteger)index
{
    if (self.elements == nil) {
        self.elements = [NSMutableArray array];
    }
    
    element.parentSection = self;
    [self.elements insertObject:element atIndex:index];
}

- (NSUInteger)indexOfElement:(QElement *)element
{
    if (self.elements) {
        return [self.elements indexOfObject:element];
    }
    return NSNotFound;
}

- (void)fetchValueIntoObject:(id)obj {
    for (QElement *el in elements){
        [el fetchValueIntoObject:obj];
    }
}

- (void)dealloc {
    for (QElement * element in self.elements) {
        element.parentSection = nil;
    }
}

- (void)bindToObject:(id)data {
    if ([self.bind length]==0 || [self.bind rangeOfString:@"iterate"].location == NSNotFound)  {
            for (QElement *el in self.elements) {
                [el bindToObject:data];
            }
        } else {
            [self.elements removeAllObjects];
        }

        [[QBindingEvaluator new] bindObject:self toData:data];

}

- (void)fetchValueUsingBindingsIntoObject:(id)data {
    for (QElement *el in self.elements) {
        [el fetchValueUsingBindingsIntoObject:data];
    }

}
@end
