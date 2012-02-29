//
//  QGenericElement.h
//  QuickDialog
//
//  Created by Ken Cooper on 2/28/12.
//  Copyright (c) 2012 Coopercode, LLC. All rights reserved.
//

#import "QElement.h"

@interface QGenericElement : QElement

// tableCellSubclass must be a subclass of
// QGenericTableViewCell.
-(id)initWithTableCellSubclass: (Class)tableCellSubclass;

@property (strong, nonatomic) id model;

@end
