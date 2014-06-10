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

#import "NSMutableArray+MoveObject.h"

@implementation NSMutableArray (MoveObject)

- (void)qd_moveObjectFromIndex:(NSUInteger)from toIndex:(NSUInteger)to
{
    if (to == from)
        return;

    id objectToMove = self[from];
    [self removeObjectAtIndex:from];
    if (to >= [self count]) {
        [self addObject:objectToMove];
    } else {
        [self insertObject:objectToMove atIndex:to];
    }
}
@end

