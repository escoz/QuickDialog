//
//  Created by escoz on 1/15/12.
//

#import <QuickDialog/QuickDialog.h>
#import "QRadioElement.h"


@interface QSegmentedElement : QRadioElement {

}
- (instancetype)initWithItems:(NSArray *)stringArray selected:(NSInteger)selected;

- (instancetype)initWithItems:(NSArray *)stringArray selected:(NSInteger)selected title:(NSString *)title;

- (instancetype)init;


@end
