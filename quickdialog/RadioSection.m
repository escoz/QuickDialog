//
//  Created by escoz on 7/12/11.
//
//  To change this template use File | Settings | File Templates.
//


#import "Section.h"
#import "Element.h"
#import "LabelElement.h"
#import "RadioItemElement.h"
#import "RadioSection.h"


@implementation RadioSection

@synthesize selected = _selected;


- (void)createElements {

    for (NSUInteger i=0; i< [_items count]; i++){
        [self addElement:[[RadioItemElement alloc] initWithIndex:i RadioSection:self]];
    }
}

- (NSArray *)items {
    return _items;
}

- (void)setItems:(NSArray *)items {
    _items = items;
    self.elements = nil;
    [self createElements];
}

- (RadioSection *)initWithItems:(NSArray *)stringArray selected:(NSUInteger)selected {
    self = [super init];
    if (self!=nil){
        _items = stringArray;
        _selected = selected;
        [self createElements];
    }
    return self;
}

- (RadioSection *)initWithItems:(NSArray *)stringArray selected:(NSUInteger)selected title:(NSString *)title {
    self = [self initWithItems:stringArray selected:selected];
    self.title = title;
    return self;
}

- (void)fetchValueIntoObject:(id)obj {
    if (_key==nil)
		return;
    [obj setValue:[NSNumber numberWithInteger:_selected] forKey:_key];
}


@end