//
//  Created by escoz on 7/12/11.
//
//  To change this template use File | Settings | File Templates.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class QElement;


@interface QTextElement : QElement {

@protected
    NSString *_text;
    UIFont *_font;
    UIColor *_color;
}

@property(nonatomic, strong) NSString *text;
@property(nonatomic, strong) UIFont *font;


@property(nonatomic, retain) UIColor *color;

- (QTextElement *)initWithText:(NSString *)string;
@end