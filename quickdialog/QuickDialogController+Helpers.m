#import "QuickDialogController+Helpers.h"
#import <objc/runtime.h>

NSString *QTranslate(NSString *value, NSString* table) {
    NSString * translated = NSLocalizedStringFromTable(value, table, nil);
    if (table && translated == value) // not found, try main file
        translated = NSLocalizedString(value, nil);
    //if ([translated isEqualToString:value])
    //    NSLog(@"\"%@\" = \"%@\";", value, value);
    return translated;
}


@implementation QuickDialogController (Helpers)
@end