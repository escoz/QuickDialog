//
//  Created by escoz on 7/8/11.
//
//  To change this template use File | Settings | File Templates.
//


#import <Foundation/Foundation.h>

@class QLabelElement;


@interface QEntryElement : QLabelElement {

@private
    NSString *_placeholder;
    NSString *_textValue;

    BOOL _hiddenToolbar;
    BOOL _isPassword;
}


@property(nonatomic, strong) NSString *textValue;
@property(nonatomic, strong) NSString *placeholder;
@property(assign) BOOL hiddenToolbar;
@property(assign) BOOL isPassword;

- (QEntryElement *)initWithTitle:(NSString *)string Value:(NSString *)param Placeholder:(NSString *)string1;
@end