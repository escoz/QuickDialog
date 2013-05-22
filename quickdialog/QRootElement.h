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

#import "QElement.h"
#import "QSection.h"


typedef enum  {
    QPresentationModeNormal = 0,
    QPresentationModePopover,
    QPresentationModeNavigationInPopover,
    QPresentationModeModalForm,
    QPresentationModeModalFullScreen,
    QPresentationModeModalPage
} QPresentationMode;

@interface QRootElement : QElement {

@protected
	BOOL _grouped;
	
    NSString *_title;
    NSMutableArray *_sections;
    NSString *_controllerName;
}

@property(nonatomic, retain) NSString *title;
@property(nonatomic, strong) NSMutableArray *sections;
@property(nonatomic, strong) NSDictionary *sectionTemplate;
@property(assign) BOOL grouped;

@property(nonatomic, retain) NSString *controllerName;

@property(nonatomic, copy) NSString *emptyMessage;
@property(nonatomic) QPresentationMode presentationMode;

@property(nonatomic, strong) NSIndexPath *preselectedElementIndex;

@property(nonatomic, copy) void (^onValueChanged)(QRootElement *);

- (QRootElement *)init;

- (void)addSection:(QSection *)section;

+ (QRootElement *)rootForJSON:(NSString *)jsonFileName withObject:(id)object;

- (QSection *)getSectionForIndex:(NSInteger)index;
- (NSInteger)numberOfSections;

- (QSection *)getVisibleSectionForIndex:(NSInteger)index;
- (NSInteger)visibleNumberOfSections;
- (NSUInteger)getVisibleIndexForSection: (QSection*)section;

- (void)fetchValueIntoObject:(id)obj;

- (void)fetchValueUsingBindingsIntoObject:(id)object;

- (QSection *)sectionWithKey:(NSString *)key;
- (QElement *)elementWithKey:(NSString *)string;

- (QRootElement *)rootWithKey:(NSString *)string;

- (void)handleEditingChanged;

@end
