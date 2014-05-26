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


#import <objc/runtime.h>
#import "QElement+Appearance.h"
#import "QSection.h"
#import "QRootElement+JsonBuilder.h"
#import "QFlatAppearance.h"


static void * const KEY_APPEARANCE_OBJECT = (void*)&KEY_APPEARANCE_OBJECT;

@implementation QElement (Appearance)


+ (QAppearance *)appearance {
    QAppearance *appearance = objc_getAssociatedObject(self, KEY_APPEARANCE_OBJECT);
    if (appearance==nil && [[self class].superclass respondsToSelector:@selector(appearance)]){
        appearance = [[self class].superclass appearance];
    }
    if (appearance==nil) {
        appearance = [QFlatAppearance new];
        [self setAppearance:appearance];
    }
    return appearance;
}

+ (void)setAppearance:(QAppearance *)newAppearance {
    objc_setAssociatedObject(self, KEY_APPEARANCE_OBJECT, newAppearance, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (QAppearance *)appearance {
    QAppearance *objAppearance = objc_getAssociatedObject(self, KEY_APPEARANCE_OBJECT);
    if (objAppearance==nil && self != self.parentSection.rootElement){
        objAppearance = self.parentSection.rootElement.appearance;
    }
    if (objAppearance==nil) {
        objAppearance = [[self class] appearance];
        self.appearance = objAppearance;
    }
    return objAppearance;
}

- (void)setAppearance:(QAppearance *)newAppearance {
    objc_setAssociatedObject(self, KEY_APPEARANCE_OBJECT, newAppearance, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
