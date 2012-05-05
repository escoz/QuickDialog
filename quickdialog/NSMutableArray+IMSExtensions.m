//
//  NSMutableArray+IMSExtensions.m
//  PsychAu
//
//  Created by Iain Stubbs on 30/01/12.
//  Copyright (c) 2012 Parallel ThirtyEight South. All rights reserved.
//

#import "NSMutableArray+IMSExtensions.h"

@implementation NSMutableArray (IMSExtensions)

- (NSString*)concatStrings
{
    NSArray *array = [NSArray arrayWithArray:self];
    return [array componentsJoinedByString: @""];
}

@end
