//
//  UIColor+ColorUtilities.m
//  Color Picker
//
//  Created by Ben Wyatt on 10/10/12.
//  Copyright (c) 2012 Quickfire Software. All rights reserved.
//

#import "UIColor+ColorUtilities.h"

@implementation UIColor (ColorUtilities)

- (UIColor *)darkerColor
{
    float r, g, b, a;
    if ([self getRed:&r green:&g blue:&b alpha:&a])
        return [UIColor colorWithRed:MAX(r - 0.4, 0.0)
                               green:MAX(g - 0.4, 0.0)
                                blue:MAX(b - 0.4, 0.0)
                               alpha:a];
    return nil;
}

- (UIImage *)imageByDrawingCircleOfColor
{
	// begin a graphics context of sufficient size
	UIGraphicsBeginImageContext(CGSizeMake(30, 30));
    
	// get the context for CoreGraphics
	CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //CGContextSetStrokeColorWithColor(ctx, [self darkerColor].CGColor);
    CGContextSetLineWidth(ctx, 1.5f);
    
	// set stroke & fill color and draw circle
    [self setFill];
    [[self darkerColor] setStroke];
    
	// make circle rect 5 px from border
	CGRect circleRect = CGRectMake(0, 0, 30, 30);
	circleRect = CGRectInset(circleRect, 8, 8);
    
	// draw circle
    CGContextFillEllipseInRect(ctx, circleRect);
    CGContextStrokeEllipseInRect(ctx, circleRect);
    
	// make image out of bitmap context
	UIImage *retImage = UIGraphicsGetImageFromCurrentImageContext();
    
	// free the context
	UIGraphicsEndImageContext();
    
	return retImage;
}

/*
 
 
 - (UIImage *)imageByDrawingCircleOfColor:(UIColor *)color
 {
 // begin a graphics context of sufficient size
 UIGraphicsBeginImageContext(CGSizeMake(30, 30));
 
 // get the context for CoreGraphics
 CGContextRef ctx = UIGraphicsGetCurrentContext();
 
 // set stroke & fill color and draw circle
 [color setStroke];
 [color setFill];
 
 // make circle rect 5 px from border
 CGRect circleRect = CGRectMake(0, 0,
 30,
 30);
 circleRect = CGRectInset(circleRect, 8, 8);
 
 // draw circle
 //	CGContextStrokeEllipseInRect(ctx, circleRect);
 
 CGContextFillEllipseInRect(ctx, circleRect);
 
 // make image out of bitmap context
 UIImage *retImage = UIGraphicsGetImageFromCurrentImageContext();
 
 // free the context
 UIGraphicsEndImageContext();
 
 return retImage;
 }
 */

@end
