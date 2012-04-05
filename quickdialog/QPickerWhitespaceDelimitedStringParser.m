//
//  QPickerWhitespaceDelimitedStringParser.m
//  QuickDialog
//
//  Created by HiveHicks on 05.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "QPickerWhitespaceDelimitedStringParser.h"

@implementation QPickerWhitespaceDelimitedStringParser

- (id)objectFromComponentsValues:(NSArray *)componentsValues
{
    return [componentsValues componentsJoinedByString:@" "];
}

- (NSArray *)componentsValuesFromObject:(id)object
{
    NSString *stringValue = [object isKindOfClass:[NSString class]] ? object : [object description];
    return [stringValue componentsSeparatedByString:@" "];
}

@end
