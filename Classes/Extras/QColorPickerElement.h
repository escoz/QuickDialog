//
//  QColorPickerElement.h
//  Color Picker
//
//  Created by Ben Wyatt on 10/7/12.
//  Copyright (c) 2012 Quickfire Software. All rights reserved.
//

#import <QuickDialog/QuickDialog.h>
#import "../Forms/QRadioElement.h"
#import "../Forms/QRadioItemElement.h"

@interface QColorPickerElement : QRadioElement


- (void)setSelectedColor:(id)color;
@end
