//
//  Created by escoz on 7/8/11.
//
//  To change this template use File | Settings | File Templates.
//


#import <Foundation/Foundation.h>

@class QLabelElement;
@class QRadioElement;
@class QRadioSection;


@interface QRadioItemElement : QLabelElement {

    NSUInteger _index;
    QRadioElement *_radioElement;
    QRadioSection *_radioSection;
}

- (QRadioItemElement *)initWithIndex:(NSUInteger)i1 RadioElement:(QRadioElement *)element;

- (QRadioItemElement *)initWithIndex:(NSUInteger)integer RadioSection:(QRadioSection *)section;
@end