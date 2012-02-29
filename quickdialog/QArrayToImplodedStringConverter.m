//
//  QArrayToImplodedStringConverter.m
//  QuickDialog
//
//  Created by Ken Cooper on 2/28/12.
//  Copyright (c) 2012 Coopercode, LLC. All rights reserved.
//

#import "QArrayToImplodedStringConverter.h"

@implementation QArrayToImplodedStringConverter

-(id)convert:(id)value argument:(NSString *)argument
{
    NSArray *array = (NSArray *)value;
    
    NSString *joinString = @", ";
    if (argument) {
        joinString = argument;
    }
    
    return [array componentsJoinedByString: joinString];
}
@end
