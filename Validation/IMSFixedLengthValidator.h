//
//  IMSFixedLengthValidator.h
//  AussiePsych
//
//  Created by Iain Stubbs on 3/04/12.
//  Copyright (c) 2012 Parallel ThirtyEight South. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IMSValidatorProtocol.h"

@interface IMSFixedLengthValidator : NSObject <IMSValidatorProtocol>
{
    NSUInteger length;
}
@property (nonatomic) NSUInteger length;

-(IMSFixedLengthValidator *)initWithLength:(NSUInteger)len;

@end
