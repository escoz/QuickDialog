//
//  SportObject.m
//  QuickDialog
//
//  Created by Petar Sokarovski on 11/15/13.
//
//

#import "SportObject.h"

@implementation SportObject

@synthesize sportName = _sportName;
@synthesize sportId = _sportId;

- (id)initWithName:(NSString *)name andId:(int)sportId {
    if (self = [super init]) {
        _sportName = name;
        _sportId = sportId;
    }
    return self;
}

- (NSString *)description {
    return _sportName;
}

@end
