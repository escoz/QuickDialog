#import "QuickDialogController+Helpers.h"


NSString *QTranslate(NSString *value) {
    NSString * translated = NSLocalizedString(value, nil);
    //if ([translated isEqualToString:value])
    //    NSLog(@"\"%@\" = \"%@\";", value, value);
    return translated;
}


@implementation QuickDialogController (Helpers)
@end
