//
//  Created by iainstubbs1959 on 21/03/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "IMSValidationPlugin.h"

@implementation IMSValidationPlugin

+ (NSString*)processValidator:(NSObject*)val andValidator:(IMSEntryValidator*)ev
{

    /*
    if ([val isKindOfClass:[DuplicateProviderValidator class]])
    {
        DuplicateProviderValidator *dp = (DuplicateProviderValidator*)val;
        NSString* result = [dp validate:ev.check];
        if ([result isEqualToString:@""])
        {
            return @"";
        }
        NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:result,@"\n",nil];
        NSString* ret = [array concatStrings];
        return ret;
    }
    else if ([val isKindOfClass:[DuplicateProviderValidator class]])
    {
        DuplicateProviderValidator *dp = (DuplicateProviderValidator*)val;
        NSString* result = [dp validate:ev.check];
        if ([result isEqualToString:@""])
        {
            return @"";
        }
        NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:result,@"\n",nil];
        NSString* ret = [array concatStrings];
        return ret;
    }

    */
    return @"";
}

@end