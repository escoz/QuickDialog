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

@class QEntryElement;


typedef enum  {
    QPresentationModeNormal = 0,
    QPresentationModePopover,
    QPresentationModeNavigationInPopover,
    QPresentationModeModalForm,
    QPresentationModeModalFullScreen,
    QPresentationModeModalPage
} QPresentationMode;

/**

  Think of a root element as a dialog: a collection of sections and cells that can be used to display some useful data to the user. Every QuickDialogController can only display one RootElement at a time, although that RootElement can contain other root elements inside, which causes a new controller to automatically be displayed. Elements are always grouped in sections in the root element, as you can see below.
*/

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
@property(assign) BOOL showKeyboardOnAppear;

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

- (QEntryElement *)findElementToFocusOnBefore:(QElement *)previous;

- (QEntryElement *)findElementToFocusOnAfter:(QElement *)element;

- (void)handleEditingChanged;

@end
