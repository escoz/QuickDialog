//
//  QColorPickerElement.h
//  Color Picker
//
//  Created by Ben Wyatt on 10/7/12.
//  Copyright (c) 2012 Quickfire Software. All rights reserved.
//

#import "QLabelElement.h"

@interface QColorPickerElement : QLabelElement

@property (nonatomic, retain) UIColor *colorValue;
@property (nonatomic, retain) NSArray *colorChoices;
@property (nonatomic, retain) NSArray *colorNames;

-(id)initWithTitle:(NSString *)title choices:(NSArray *)choices names:(NSArray *)names andValue:(UIColor *)value;

@end
