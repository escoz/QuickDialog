//
//  Created by escoz on 11/1/11.
//
#import <Foundation/Foundation.h>
#import "QRootElement.h"


@interface QRootElement (JSONBuilder)

- (id)initWithJSONFile:(NSString *)json andData:(id)data;

- (QElement *)buildElementWithObject:(id)obj;

- (id)initWithJSONFile:(NSString *)jsonPath;

+ (BOOL)jsonAvailable;

@end