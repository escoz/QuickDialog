//
//  Created by escoz on 7/8/11.
//
//  To change this template use File | Settings | File Templates.
//


#import <Foundation/Foundation.h>

@class LabelElement;
@class RadioElement;
@class RadioSection;


@interface RadioItemElement : LabelElement {

    NSUInteger _index;
    RadioElement *_radioElement;
    RadioSection *_radioSection;
}

- (RadioItemElement *)initWithIndex:(NSUInteger)i1 RadioElement:(RadioElement *)element;

- (RadioItemElement *)initWithIndex:(NSUInteger)integer RadioSection:(RadioSection *)section;
@end