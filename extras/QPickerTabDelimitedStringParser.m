//
//  QPickerTabDelimitedStringParser.m
//  QuickDialog
//
//  Created by HiveHicks on 05.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "QPickerTabDelimitedStringParser.h"

@implementation QPickerTabDelimitedStringParser

- (id)objectFromComponentsValues:(NSArray *)componentsValues
{
    return [componentsValues componentsJoinedByString:@"\t"];
}

- (NSArray *)componentsValuesFromObject:(id)object
{
    NSString *stringValue = [object isKindOfClass:[NSString class]] ? object : [object description];
    return [stringValue componentsSeparatedByString:@"\t"];
}

@end
