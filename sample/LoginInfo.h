//
//  Created by escoz on 7/26/11.
//
//  To change this template use File | Settings | File Templates.
//


#import <Foundation/Foundation.h>


@interface LoginInfo : NSObject {

@private
    NSString *_password;
    NSString *_login;
}

@property(retain) NSString *login;
@property(retain) NSString *password;

@end