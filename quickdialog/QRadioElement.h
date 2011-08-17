//
//  Created by escoz on 7/8/11.
//
//  To change this template use File | Settings | File Templates.
//


#import <Foundation/Foundation.h>

@class QRootElement;
@class QSection;

@interface QRadioElement : QRootElement {

    NSArray *_items;
    NSUInteger _selected;
}

@property(nonatomic, readonly) NSArray *items;
@property(nonatomic, assign, readwrite) NSUInteger selected;

- (QRadioElement *)initWithItems:(NSArray *)stringArray selected:(NSUInteger)selected;
- (QRadioElement *)initWithItems:(NSArray *)stringArray selected:(NSUInteger)selected title:(NSString *)title;
@end