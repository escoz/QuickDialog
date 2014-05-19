//
//  NSString+UIStringDrawing2.m
//  QuickDialog
//
//  Created by Ryo Miyake on 2014/05/19.
//
//

#import "NSString+UIStringDrawing2.h"

@implementation NSString (UIStringDrawing2)

- (CGSize)sizeWithFont2:(UIFont*)font
{
    if([self respondsToSelector:@selector(sizeWithAttributes:)]){
        return [self sizeWithAttributes:@{NSFontAttributeName:font}];
    }else{
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
        return [self sizeWithFont:font];
#pragma GCC diagnostic warning "-Wdeprecated-declarations"
    }
}

- (CGSize)sizeWithFont2:(UIFont*)font forWidth:(CGFloat)width lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    if([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]){
        NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        style.lineBreakMode = lineBreakMode;
        return [self boundingRectWithSize:CGSizeMake(width,FLT_MAX)
                                  options:NSStringDrawingUsesLineFragmentOrigin
                               attributes:@{
                                            NSFontAttributeName:font,
                                            NSParagraphStyleAttributeName:style,
                                            }
                                  context:nil].size;
    }else{
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
        return [self sizeWithFont:font forWidth:width lineBreakMode:lineBreakMode];
#pragma GCC diagnostic warning "-Wdeprecated-declarations"
    }
}

- (CGSize)sizeWithFont2:(UIFont*)font constrainedToSize:(CGSize)size
{
    if([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]){
        NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        style.lineBreakMode = NSLineBreakByWordWrapping;
        return [self boundingRectWithSize:size
                                  options:NSStringDrawingUsesLineFragmentOrigin
                               attributes:@{
                                            NSFontAttributeName:font,
                                            NSParagraphStyleAttributeName:style,
                                            }
                                  context:nil].size;
    }else{
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
        return [self sizeWithFont:font constrainedToSize:size];
#pragma GCC diagnostic warning "-Wdeprecated-declarations"
    }
}

- (CGSize)sizeWithFont2:(UIFont*)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    if([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]){
        NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        style.lineBreakMode = lineBreakMode;
        style.alignment = NSTextAlignmentLeft;
        return [self boundingRectWithSize:size
                                  options:NSStringDrawingUsesLineFragmentOrigin
                               attributes:@{
                                            NSFontAttributeName:font,
                                            NSParagraphStyleAttributeName:style,
                                            }
                                  context:nil].size;
    }else{
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
        return [self sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode];
#pragma GCC diagnostic warning "-Wdeprecated-declarations"
    }
}

- (void)drawInRect2:(CGRect)rect withFont:(UIFont*)font lineBreakMode:(NSLineBreakMode)lineBreakMode alignment:(NSTextAlignment)alignment
{
    if([self respondsToSelector:@selector(drawInRect:withAttributes:)]){
        NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        style.lineBreakMode = lineBreakMode;
        style.alignment = alignment;
        [self drawInRect:rect
          withAttributes:@{
                           NSFontAttributeName:font,
                           NSParagraphStyleAttributeName:style,
                           }];
    }else{
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
        [self drawInRect:rect withFont:font lineBreakMode:lineBreakMode alignment:alignment];
#pragma GCC diagnostic warning "-Wdeprecated-declarations"
    }
}

@end
