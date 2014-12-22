//
//  UIColor+ColorUtilities.m
//  Color Picker
//
//  Created by Ben Wyatt on 10/10/12.
//  Copyright (c) 2012 Quickfire Software. All rights reserved.
//

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

- (UIImage *)imageByDrawingCircleOfColor {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(30, 30), NO, [UIScreen mainScreen].scale);
	CGContextRef ctx = UIGraphicsGetCurrentContext();

    CGContextSetLineWidth(ctx, 1.5f);
    [self setFill];

    [[self darkerColor] setStroke];
    CGRect circleRect = CGRectMake(0, 0, 30, 30);
	circleRect = CGRectInset(circleRect, 8, 8);
    CGContextFillEllipseInRect(ctx, circleRect);
    CGContextStrokeEllipseInRect(ctx, circleRect);

    UIImage *retImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
    
	return retImage;
}

@end
