//
//  QSelectElement.h
//  DealerFire2
//
//  Created by M.Y. on 12/12/12.
//  Copyright (c) 2012 DealerFire. All rights reserved.
//

#import "QRadioElement.h"

@interface QSelectElement : QRadioElement

- (id)initWithItems:(NSArray *)items selectedIndexes:(NSArray *)selected;

@end
