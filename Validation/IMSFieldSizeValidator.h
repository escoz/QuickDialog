//
//  Created by iainstubbs1959 on 21/03/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface IMSFieldSizeValidator : NSObject <IMSValidatorProtocol>
{
    NSUInteger minimum;
    NSUInteger maximum;
}
@property (nonatomic) NSUInteger minimum;
@property (nonatomic) NSUInteger maximum;

-(IMSFieldSizeValidator *)initWithMin:(NSUInteger)min andMax:(NSUInteger)max;

@end