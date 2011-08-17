//
//  Created by escoz on 7/14/11.
//

#import "QSection.h"
#import "QSortingSection.h"


@implementation QSortingSection


@synthesize sortingEnabled = _sortingEnabled;

- (QSortingSection *)init {
    self = [super init];
    self.sortingEnabled = YES;
    return self;

}

- (BOOL)needsEditing {
    return _sortingEnabled;
}

- (void)fetchValueIntoObject:(id)obj {
    if (_key == nil)
       return;

    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (QElement *el in self.elements){
        [result addObject:el.key];
    }

    [obj setValue:result forKey:_key];

}

- (void)moveElementFromRow:(NSUInteger)from toRow:(NSUInteger)to {
    [self.elements exchangeObjectAtIndex:from withObjectAtIndex:to];
}
@end