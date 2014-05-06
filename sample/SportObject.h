//
//  SportObject.h
//  QuickDialog
//
//  Created by Petar Sokarovski on 11/15/13.
//
//

#import <Foundation/Foundation.h>

@interface SportObject : NSObject

@property (nonatomic, retain) NSString *sportName;
@property (nonatomic) int sportId;

- (id)initWithName:(NSString *)name andId:(int)sportId;

@end
