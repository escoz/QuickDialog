//
//  QColorPickerElement.m
//  Color Picker
//
//  Created by Ben Wyatt on 10/7/12.
//  Copyright (c) 2012 Quickfire Software. All rights reserved.
//

#import "QColorPickerElement.h"
#import "QColorPickerViewController.h"
#import "UIColor+ColorUtilities.h"
#import <QuartzCore/QuartzCore.h>

@implementation QColorPickerElement 

@synthesize colorValue, colorNames, colorChoices;

-(id)initWithTitle:(NSString *)initTitle Value:(UIColor *)initValue
{
    if (self = [super initWithTitle:initTitle Value:nil])
    {
        self.colorChoices = [NSArray arrayWithObjects:[UIColor blackColor], [UIColor whiteColor], [UIColor grayColor], [UIColor blueColor], [UIColor redColor], [UIColor greenColor], [UIColor yellowColor], [UIColor purpleColor], [UIColor magentaColor], nil];
        
        self.colorNames = [NSArray arrayWithObjects:@"Black", @"White", @"Gray", @"Blue", @"Red", @"Green", @"Yellow", @"Purple", @"Magenta", nil];
        
        self.colorValue = initValue;
    }
    
    return self;
}

-(id)initWithTitle:(NSString *)title choices:(NSArray *)choices names:(NSArray *)names andValue:(UIColor *)value
{
    if (self = [super initWithTitle:title Value:nil])
    {
        // Create default colors and names, if not provided
        if (choices == nil)
        {
            self.colorChoices = [NSArray arrayWithObjects:[UIColor blackColor], [UIColor whiteColor], [UIColor grayColor], [UIColor blueColor], [UIColor redColor], [UIColor greenColor], [UIColor yellowColor], [UIColor purpleColor], [UIColor magentaColor], nil];
            
            self.colorNames = [NSArray arrayWithObjects:@"Black", @"White", @"Gray", @"Blue", @"Red", @"Green", @"Yellow", @"Purple", @"Magenta", nil];
                                 
        }
        else
        {
            self.colorNames = names;
            self.colorChoices = choices;   
        }
        
        self.colorValue = value;
    }
    
    return self;
}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller 
{
    
    QTableViewCell *cell = (QTableViewCell *) [super getCellForTableView:tableView controller:controller];

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    
    cell.textLabel.text = _title;
    
    cell.imageView.image = [colorValue imageByDrawingCircleOfColor];
    
    return cell;
}

- (void)selected:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller indexPath:(NSIndexPath *)indexPath
{
    QColorPickerViewController *picker = [[QColorPickerViewController alloc] initWithColors:colorChoices andNames:colorNames withSelected:colorValue];
    
    [picker setSelectedColor:colorValue];
    
    __block QColorPickerElement *weakself = self;
    __block QColorPickerViewController *weakPicker = picker;
    picker.dismissCallback = ^{
        weakself.colorValue = weakPicker.selectedColor;
        [[tableView cellForElement:weakself] setNeedsDisplay];
    };
    
    [controller displayViewController:picker];
    
    return;
}

@end
