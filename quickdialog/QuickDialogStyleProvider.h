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


@class QElement;
@class QSection;

@protocol QuickDialogStyleProvider

-(void) cell:(UITableViewCell *)cell willAppearForElement:(QElement *)element atIndexPath:(NSIndexPath *)indexPath; 

@optional

-(void) sectionHeaderWillAppearForSection:(QSection *)section atIndex:(NSInteger)indexPath;
-(void) sectionFooterWillAppearForSection:(QSection *)section atIndex:(NSInteger)indexPath;

@end