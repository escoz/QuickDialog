//
//  Created by escoz on 1/15/12.
//

#import <Foundation/Foundation.h>

#import "QRadioElement.h"

@interface QSegmentedElement : QRadioElement {

}
- (QSegmentedElement *)initWithItems:(NSArray *)stringArray selected:(NSInteger)selected;

- (QSegmentedElement *)initWithItems:(NSArray *)stringArray selected:(NSInteger)selected title:(NSString *)title;

- (QSegmentedElement *)init;


@end
