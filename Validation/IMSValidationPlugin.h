//
//  Created by iainstubbs1959 on 21/03/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "Validation.h"

@interface IMSValidationPlugin : NSObject

+ (NSString*)processValidator:(NSObject*)val andValidator:(IMSEntryValidator*)ev;

@end