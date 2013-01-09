#import <objc/runtime.h>
#import "QElement+Appearance.h"


static void * const KEY_APPEARANCE_OBJECT = (void*)&KEY_APPEARANCE_OBJECT;

@implementation QElement (Appearance)


+ (NSMutableDictionary *)appearance {
    NSMutableDictionary *appearance = objc_getAssociatedObject(self, &KEY_APPEARANCE_OBJECT);
    if (appearance==nil && [[self class].superclass respondsToSelector:@selector(appearance)]){
        appearance = [[self class].superclass appearance];
    }
    if (appearance==nil) {
        appearance = [NSMutableDictionary new];
        [self setAppearance:appearance];
    }
    return appearance;
}

+ (void)setAppearance:(NSMutableDictionary *)newAppearance {
    objc_setAssociatedObject(self, &KEY_APPEARANCE_OBJECT, newAppearance, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (NSMutableDictionary *)appearance {
    NSMutableDictionary *objAppearance = objc_getAssociatedObject(self, &KEY_APPEARANCE_OBJECT);
    if (objAppearance==nil) {
        NSLog(@"Reading from obj class %@ - %@", self.class,  [(QElement *)self.class appearance]);
        objAppearance = [[(QElement *)self.class appearance] mutableCopy];
        self.appearance = objAppearance;
    }
    return objAppearance;
}

- (void)setAppearance:(NSMutableDictionary *)newAppearance {
    objc_setAssociatedObject(self, &KEY_APPEARANCE_OBJECT, newAppearance, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
