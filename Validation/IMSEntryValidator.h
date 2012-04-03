//
//  IMSEntryValidator.h
//  AussiePsych
//
//  Created by Iain Stubbs on 14/03/12.
//  Copyright (c) 2012 Parallel ThirtyEight South. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IMSValidatorProtocol.h"

@interface IMSEntryValidator : NSObject
{
    NSMutableArray* validations;
    IMSValidationCheck* check;
    NSMutableArray* checks;
    NSString* groupName;
}

@property (nonatomic,retain)NSMutableArray* validations;
@property (nonatomic,retain)IMSValidationCheck* check;
@property (nonatomic,retain)NSMutableArray* checks;
@property (nonatomic,retain)NSString* groupName;

- (IMSEntryValidator*)initWithValidations:(NSMutableArray*)validations andCheck:(IMSValidationCheck*)theCheck;

- (IMSEntryValidator*)initWithValidation:(NSObject*)validation andCheck:(IMSValidationCheck*)theCheck;

- (IMSEntryValidator*)initWithValidation:(NSObject*)validation andChecks:(NSMutableArray*)theChecks;

@end
