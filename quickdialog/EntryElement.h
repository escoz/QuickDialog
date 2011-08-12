//
//  Created by escoz on 7/8/11.
//
//  To change this template use File | Settings | File Templates.
//


#import <Foundation/Foundation.h>

@class LabelElement;


@interface EntryElement : LabelElement {

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

- (EntryElement *)initWithTitle:(NSString *)string Value:(NSString *)param Placeholder:(NSString *)string1;
@end