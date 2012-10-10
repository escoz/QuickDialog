//
//  QColorPickerViewController.m
//  Color Picker
//
//  Created by Ben Wyatt on 10/7/12.
//  Copyright (c) 2012 Quickfire Software. All rights reserved.
//

#import "QColorPickerViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UIColor+ColorUtilities.h"


@implementation QColorPickerViewController

@synthesize plistName, selectedColor, dismissCallback, rowHeight, colors, colorNames, colorChoices;

-(id)initWithColors:(NSArray *)choices andNames:(NSArray *)names withSelected:(UIColor *)selected
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self)
    {
        self.colorNames = names;
        self.colorChoices = choices;
        self.selectedColor = selected;
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    [self.tableView reloadData];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (dismissCallback != nil)
    {
        dismissCallback();
    }
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    if ([colorNames count] > 0)
    {
        return 1;
    }
    else
    {
        return 0;        
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [colorNames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    UIColor *thisColor = [colorChoices objectAtIndex:[indexPath row]];
    
    // Configure the cell...
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.text = [colorNames objectAtIndex:[indexPath row]];
    
    //cell.imageView.backgroundColor = [colorChoices objectAtIndex:[indexPath row]];
    cell.imageView.image = [thisColor imageByDrawingCircleOfColor];
    
    if (CGColorEqualToColor(thisColor.CGColor, selectedColor.CGColor))
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedColor = [colorChoices objectAtIndex:[indexPath row]];
    [self.tableView reloadData];
}

@end
