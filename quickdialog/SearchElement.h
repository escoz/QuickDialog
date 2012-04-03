//
// SearchElement.h
//  AussiePsych
//
//  Created by Iain Stubbs on 9/03/12.
//  Copyright (c) 2012 Parallel ThirtyEight South. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchElement : NSObject
{
    NSString *detail;
    NSString *key;
}
@property(nonatomic,retain) NSString* detail;
@property(nonatomic,retain) NSString* key;

- (id)initWithDetail:(NSString*)theDetail andKey:(NSString*)theKey;
- (NSString*)retrieveDetail;
- (NSString*)retrieveKey;

@end
