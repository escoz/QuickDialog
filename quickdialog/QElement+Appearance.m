#import <objc/runtime.h>
#import "QElement+Appearance.h"
#import "QClassicAppearance.h"


static void * const KEY_APPEARANCE_OBJECT = (void*)&KEY_APPEARANCE_OBJECT;

@implementation QElement (Appearance)


+ (QAppearance *)appearance {
    QAppearance *appearance = objc_getAssociatedObject(self, KEY_APPEARANCE_OBJECT);
    if (appearance==nil && [[self class].superclass respondsToSelector:@selector(appearance)]){
        appearance = [[self class].superclass appearance];
    }
    if (appearance==nil) {
#if __IPHONE_7_0
        appearance = [[[UIDevice currentDevice] systemVersion] floatValue]>=7.f ? [QFlatAppearance new] : [QClassicAppearance new];
#else
        appearance = [QClassicAppearance new];
#endif
        [self setAppearance:appearance];
    }
    return appearance;
}

+ (void)setAppearance:(QAppearance *)newAppearance {
    objc_setAssociatedObject(self, KEY_APPEARANCE_OBJECT, newAppearance, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (QAppearance *)appearance {
    QAppearance *objAppearance = objc_getAssociatedObject(self, KEY_APPEARANCE_OBJECT);
    if (objAppearance==nil){
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
