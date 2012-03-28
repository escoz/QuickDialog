//
//  IMSValidatorProtocol.h
//  AussiePsych
//
//  Created by Iain Stubbs on 12/03/12.
//  Copyright (c) 2012 Parallel ThirtyEight South. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IMSValidationCheck.h"

@protocol IMSValidatorProtocol

@optional
- (NSString*)validate:(IMSValidationCheck*)theCheck;
- (NSString*) validateChecks:(NSMutableArray*)theChecks;

@end
