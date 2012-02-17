//
//  QValidator.h
//  QuickDialog
//
//  Created by Ken Cooper on 2/9/12.
//  Copyright (c) 2012 Coopercode, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QValidator : NSObject
// Answer a string describing the problem with the element,
// nil if no problem.
-(NSString *)validate: (QElement *)element;
@end

