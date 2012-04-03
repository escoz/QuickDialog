//
//  IMSValidationCheck.m
//  AussiePsych
//
//  Created by Iain Stubbs on 15/03/12.
//  Copyright (c) 2012 Parallel ThirtyEight South. All rights reserved.
//

#import "IMSValidationCheck.h"

@implementation IMSValidationCheck

@synthesize input;
@synthesize fieldName;
@synthesize article;
@synthesize username;
@synthesize password;

- (IMSValidationCheck*)initWithInputAndUser:(NSString*)theInput andField:(NSString*)theField andArticle:(NSString*)theArticle andUser:(NSString*)theUser andPassword:(NSString*)thePassword

{
    self = [super init];
    self.input = theInput;
    self.fieldName = theField;
    self.article = theArticle;
    self.username = theUser;
    self.password = thePassword;
    
    return self;
}

- (IMSValidationCheck*)initWithInput:(NSString*)theInput andField:(NSString*)theField andArticle:(NSString*)theArticle
{
    self = [super init];
    self.input = theInput;
    self.fieldName = theField;
    self.article = theArticle;
    self.username = nil;
    self.password = nil;
    
    return self;
}

@end
