//
//  QButtonImageColours.m
//  AussiePsych
//
//  Created by Iain Stubbs on 3/03/12.
//  Copyright (c) 2012 Parallel ThirtyEight South. All rights reserved.
//

#import "QButtonImageColours.h"

@implementation QButtonImageColours

@synthesize disabledColor;
@synthesize enabledColor;

- (id)initWithEnabled:(UIColor*)enabled andDisabled:(UIColor*)disabled
{
    self = [super init];
    enabledColor = enabled;
    disabledColor = disabled;
    return self;
}

- (void)setEnabled:(UIColor*)enabled andDisabled:(UIColor*)disabled
{
    enabledColor = enabled;
    disabledColor = disabled;
}

@end
