//
// Copyright 2011 ESCOZ Inc  - http://escoz.com
// Created by hivehicks on 5/23/12.
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


#import "QTextField.h"

@implementation QTextField

- (void)drawTextInRect:(CGRect)rect
{
    if (_prefix || _suffix) {
        NSString *textWithSuffix = [NSString stringWithFormat:@"%@%@%@", _prefix ? _prefix : @"", self.text, _suffix ? _suffix : @""];

        NSDictionary *dictionary = @{ NSFontAttributeName: self.font,
                NSForegroundColorAttributeName: self.textColor};
        [textWithSuffix drawInRect:rect withAttributes:dictionary];
    } else {
        [super drawTextInRect:rect];
    }
}

@end
