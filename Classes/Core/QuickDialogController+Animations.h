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
//

#import "QuickDialogController.h"

@interface QuickDialogController (Animations)

- (void)switchElementsWithAnimation:(UITableViewRowAnimation)animation elements:(NSArray *)elements;

- (void) hideElementsWithAnimation:(UITableViewRowAnimation)animation elements:(NSArray*)elements;
- (void) hideSectionsWithAnimation:(UITableViewRowAnimation)animation sections:(NSArray*)sections;
- (void) showElementsWithAnimation:(UITableViewRowAnimation)animation elements:(NSArray*)elements;
- (void) showSectionsWithAnimation:(UITableViewRowAnimation)animation sections:(NSArray*)sections;

- (void) showHideElementsWithInsertAnimation:(UITableViewRowAnimation)insertAnimation removeAnimation:(UITableViewRowAnimation)removeAnimation elementsToInsert:(NSArray*)ins elementsToRemove:(NSArray*) del;
- (void) showHideSectionsWithInsertAnimation:(UITableViewRowAnimation)insertAnimation removeAnimation:(UITableViewRowAnimation)removeAnimation sectionsToInsert:(NSArray*)ins sectionsToRemove:(NSArray*)del;

@end
