//
//  Created by escoz on 7/12/11.
//
//  To change this template use File | Settings | File Templates.
//


#import <Foundation/Foundation.h>

@class QSection;


@interface QRadioSection : QSection {

@protected
    NSArray *_items;
    NSInteger _selected;
}

@property(nonatomic, strong) NSArray *items;
@property(nonatomic) NSInteger selected;


- (QRadioSection *)initWithItems:(NSArray *)stringArray selected:(NSUInteger)selected;

- (QRadioSection *)initWithItems:(NSArray *)stringArray selected:(NSUInteger)selected title:(NSString *)title;


@end