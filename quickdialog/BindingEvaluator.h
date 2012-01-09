//
//  Created by escoz on 1/8/12.
//

#import <Foundation/Foundation.h>


@interface BindingEvaluator : NSObject {
}

- (void)bindObject:(id)section toData:(id)data;

- (void)bindSection:(QSection *)section toCollection:(NSArray *)items;

- (void)bindSection:(QSection *)section toProperties:(id)object;
@end