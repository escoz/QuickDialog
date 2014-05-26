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

#import "QuickDialogTableView.h"
#import "QRadioSection.h"
#import "QRootElement.h"
#import "QRadioItemElement.h"

@implementation QRadioSection

- (NSInteger)selected
{
    return [[self.selectedIndexes objectAtIndex:0] unsignedIntegerValue];
}

- (void)setSelected:(NSInteger)selected
{
    [self.selectedIndexes replaceObjectAtIndex:0 withObject:[NSNumber numberWithUnsignedInteger:selected]];
}


@end
