//
//  Created by escoz on 7/7/11.
//
//  To change this template use File | Settings | File Templates.
//


#import "QSection.h"
#import "QElement.h"
#import "QRootElement.h"


@implementation QSection

@synthesize title;
@synthesize footer;
@synthesize elements;
@synthesize rootElement = _rootElement;
@synthesize key = _key;
@synthesize headerView = _headerView;
@synthesize footerView = _footerView;
@synthesize entryPosition = _entryPosition;


- (BOOL)needsEditing {
    return NO;
}

- (QSection *)initWithTitle:(NSString *)sectionTitle {
    self = [super init];
    if (self) {
        self.title = sectionTitle;
    }
    return self;
}

- (void)addElement:(QElement *)element {
    if (self.elements==nil)
            self.elements = [[NSMutableArray alloc] init];

    [self.elements addObject:element];
    element.parentSection = self;
}

- (void)fetchValueIntoObject:(id)obj {
    for (QElement *el in elements){
        [el fetchValueIntoObject:obj];
    }
}


@end