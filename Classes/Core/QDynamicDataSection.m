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


#import "QDynamicDataSection.h"
#import "QuickDialog.h"
#import "QEmptyListElement.h"

@implementation QDynamicDataSection {
    BOOL showLoading;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _emptyMessage = @"Empty";
        [self addElement:[[QLoadingElement alloc] init]];
    }
    return self;
}

- (void)bindToObject:(id)data withString:(NSString *)withBindString
{

    [self.elements removeAllObjects];

    [super bindToObject:data withString:withBindString];
    
    if (self.elements.count>0) //elements exist
        return;
    
    NSArray *collection;
    
    for (NSString *each in [self.bind componentsSeparatedByString:@","]) {
        NSArray *bindingParams = [each componentsSeparatedByString:@":"];
        NSString *propName = [((NSString *) bindingParams[0]) stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSString *valueName = [((NSString *) bindingParams[1]) stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        if ([propName isEqualToString:@"iterate"]) {
            collection = [data valueForKeyPath:valueName];
        }
    }

    if (collection==nil && showLoading)
        [self addElement:[[QLoadingElement alloc] init]];
    
    if (collection!=nil && collection.count==0)
        [self addElement:[[QEmptyListElement alloc] initWithTitle:_emptyMessage Value:nil]];
}


@end
