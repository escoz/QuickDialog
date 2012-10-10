//
//  QColorPickerViewController.h
//  Color Picker
//
//  Created by Ben Wyatt on 10/7/12.
//  Copyright (c) 2012 Quickfire Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QColorPickerViewController : UITableViewController

@property (nonatomic, retain) NSString *plistName;
@property (nonatomic, retain) UIColor *selectedColor;
@property (nonatomic, retain) NSArray *colors;

@property (nonatomic, retain) NSArray *colorNames;
@property (nonatomic, retain) NSArray *colorChoices;

@property (nonatomic, copy) void (^dismissCallback)(void);
@property (nonatomic) float rowHeight;

-(id)initWithColors:(NSArray *)colors andNames:(NSArray *)names withSelected:(UIColor *)selected;

@end
