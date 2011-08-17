//
//  Created by escoz on 7/14/11.
//
//  To change this template use File | Settings | File Templates.
//


#import <Foundation/Foundation.h>

@class QSection;


@interface QSortingSection : QSection {

    BOOL _sortingEnabled;
}

@property(nonatomic, assign) BOOL sortingEnabled;


- (void)moveElementFromRow:(NSUInteger)from toRow:(NSUInteger)to;

@end