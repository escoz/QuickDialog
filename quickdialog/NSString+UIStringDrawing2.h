//
//  NSString+UIStringDrawing2.h
//  QuickDialog
//
//  Created by Ryo Miyake on 2014/05/19.
//
//

#import <Foundation/Foundation.h>

@interface NSString (UIStringDrawing2)

- (CGSize)sizeWithFont2:(UIFont*)font;
- (CGSize)sizeWithFont2:(UIFont*)font forWidth:(CGFloat)width lineBreakMode:(NSLineBreakMode)lineBreakMode;
- (CGSize)sizeWithFont2:(UIFont*)font constrainedToSize:(CGSize)size;
- (CGSize)sizeWithFont2:(UIFont*)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;
- (void)drawInRect2:(CGRect)rect withFont:(UIFont*)font lineBreakMode:(NSLineBreakMode)lineBreakMode alignment:(NSTextAlignment)alignment;

@end
