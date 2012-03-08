//
//  QGenericElement.h
//  QuickDialog
//
//  Created by Ken Cooper on 2/28/12.
//  Copyright (c) 2012 Coopercode, LLC. All rights reserved.
//

#import "QElement.h"

@class QGenericTableViewCell;

@protocol QEventDelegate <NSObject>
-(void)cellEvent: (NSString *)eventName argument: (id)argument tableCell: (UITableViewCell *)cell;
@end

@interface QGenericElement : QElement


// tableCellSubclass must be a subclass of
// QGenericTableViewCell.
-(id)initWithTableCellSubclass: (Class)tableCellSubclass;


@property (strong, nonatomic) id model;
@property (unsafe_unretained, nonatomic) id<QEventDelegate> eventDelegate;

@end
