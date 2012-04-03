//
//  IMSValidationCheck.h
//  AussiePsych
//
//  Created by Iain Stubbs on 15/03/12.
//  Copyright (c) 2012 Parallel ThirtyEight South. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IMSValidationCheck : NSObject
{
    NSString* input;
    NSString* fieldName;
    NSString* article;
    NSString* username;
    NSString* password;
}

@property (nonatomic, retain) NSString* input;
@property (nonatomic, retain) NSString* fieldName;
@property (nonatomic, retain) NSString* article;
@property (nonatomic, retain) NSString* username;
@property (nonatomic, retain) NSString* password;

- (IMSValidationCheck*)initWithInputAndUser:(NSString*)theInput andField:(NSString*)theField andArticle:(NSString*)theArticle andUser:(NSString*)theUser andPassword:(NSString*)thePassword;
- (IMSValidationCheck*)initWithInput:(NSString*)theInput andField:(NSString*)theField andArticle:(NSString*)theArticle;

@end
