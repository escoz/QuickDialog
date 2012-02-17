//
//  QTextValidator.h
//  QuickDialog
//
//  Created by Ken Cooper on 2/9/12.
//  Copyright (c) 2012 Coopercode, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QValidator.h"

@interface QEntryValidator : QValidator

+(QEntryValidator *)emailField: (NSString *)errorText;
+(QEntryValidator *)requiredField: (NSString *)errorText;

@property (strong, nonatomic) NSString *regexPattern;
@property (strong, nonatomic) NSString *requiredFieldText;
@property (strong, nonatomic) NSString *regexFailedText;
@end
