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

@implementation QSection {
@private
    NSString *_headerImage;
    NSString *_footerImage;
}
@synthesize title;
@synthesize footer;
@synthesize elements;
@synthesize rootElement = _rootElement;
@synthesize key = _key;
@synthesize headerView = _headerView;
@synthesize footerView = _footerView;
@synthesize entryPosition = _entryPosition;
@synthesize headerImage = _headerImage;
@synthesize footerImage = _footerImage;


- (BOOL)needsEditing {
    return NO;
}

- (void)setFooterImage:(NSString *)imageName {
    _footerImage = imageName;
    self.footerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_footerImage]];
}

- (void)setHeaderImage:(NSString *)imageName {
    _headerImage = imageName;
    self.headerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_headerImage]];
}

- (QSection *)initWithTitle:(NSString *)sectionTitle {
    self = [super init];
    if (self) {
        self.title = sectionTitle;
    }
    return self;
}

- (void)addElement:(QElement *)element {
    if (self.elements==nil)
            self.elements = [[NSMutableArray alloc] init];

    [self.elements addObject:element];
    element.parentSection = self;
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


@end