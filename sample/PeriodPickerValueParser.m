//
//  AMPeriodPickerValueParser.m
//  AutoMobile
//
//  Created by HiveHicks on 11.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PeriodPickerValueParser.h"

@implementation PeriodPickerValueParser {
    NSDictionary *valuesMap;
}

- (id)init
{
    if (self = [super init])
    {
        valuesMap =
            [NSDictionary dictionaryWithObjectsAndKeys:
             @"daily",      [NSNumber numberWithUnsignedInteger:NSDayCalendarUnit],
             @"weekly",     [NSNumber numberWithUnsignedInteger:NSWeekCalendarUnit],
             @"monthly",    [NSNumber numberWithUnsignedInteger:NSMonthCalendarUnit],
             @"yearly",     [NSNumber numberWithUnsignedInteger:NSYearCalendarUnit], nil];
    }
    
    return self;
}

- (NSArray *)stringPeriods
{
    return [valuesMap allValues];
}

- (id)objectFromComponentsValues:(NSArray *)componentsValues
{
    NSString *stringPeriod = [componentsValues objectAtIndex:0];
    for (NSNumber *calendarUnitWrapper in valuesMap) {
        if ([[valuesMap objectForKey:calendarUnitWrapper] isEqualToString:stringPeriod]) {
            return calendarUnitWrapper;
        }
    }
    return nil;
}

- (NSArray *)componentsValuesFromObject:(id)object
{
    return [NSArray arrayWithObject:[valuesMap objectForKey:object]];
}

- (NSString *)presentationOfObject:(id)object
{
    return [valuesMap objectForKey:object];
}

@end
