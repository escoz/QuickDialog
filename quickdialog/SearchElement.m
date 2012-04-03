//
//  SearchElement.m
//  AussiePsych
//
//  Created by Iain Stubbs on 9/03/12.
//  Copyright (c) 2012 Parallel ThirtyEight South. All rights reserved.
//

#import "SearchElement.h"

@implementation SearchElement

@synthesize detail;
@synthesize key;

- (id)initWithDetail:(NSString*)theDetail andKey:(NSString*)theKey
{
    self = [super init];
    self.detail  = theDetail;
    self.key = theKey;
    
    return self;
}

- (NSString*)retrieveDetail
{
    return self.detail;
}

- (NSString*)retrieveKey
{
    return self.key;
}

@end
