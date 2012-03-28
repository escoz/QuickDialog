//
//  QButtonImageColours.h
//  AussiePsych
//
//  Created by Iain Stubbs on 3/03/12.
//  Copyright (c) 2012 Parallel ThirtyEight South. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QButtonImageColours : NSObject
{
    UIColor* enabledColor;
    UIColor* disabledColor;
}

@property (nonatomic, retain) UIColor* enabledColor;
@property (nonatomic, retain) UIColor* disabledColor;

- (id)initWithEnabled:(UIColor*)enabled andDisabled:(UIColor*)disabled;
- (void)setEnabled:(UIColor*)enabled andDisabled:(UIColor*)enabled;

@end
