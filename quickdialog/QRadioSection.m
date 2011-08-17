//
//  Created by escoz on 7/12/11.
//
//  To change this template use File | Settings | File Templates.
//


#import "QSection.h"
#import "QElement.h"
#import "QLabelElement.h"
#import "QRadioItemElement.h"
#import "QRadioSection.h"


@implementation QRadioSection

@synthesize selected = _selected;


- (void)createElements {

    for (NSUInteger i=0; i< [_items count]; i++){
        [self addElement:[[QRadioItemElement alloc] initWithIndex:i RadioSection:self]];
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

- (QRadioSection *)initWithItems:(NSArray *)stringArray selected:(NSUInteger)selected {
    self = [super init];
    if (self!=nil){
        _items = stringArray;
        _selected = selected;
        [self createElements];
    }
    return self;
}

- (QRadioSection *)initWithItems:(NSArray *)stringArray selected:(NSUInteger)selected title:(NSString *)title {
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