//
//  Created by iainstubbs1959 on 21/03/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface IMSNumberRangeValidator : NSObject
{
    NSInteger minimum;
    NSInteger maximum;
}
@property (nonatomic) NSInteger minimum;
@property (nonatomic) NSInteger maximum;

-(IMSNumberRangeValidator *)initWithMin:(NSInteger)min andMax:(NSInteger)max;

@end