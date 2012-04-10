//
//  IMSSearchDisplayController.m
//  AussiePsych
//
//  Created by Iain Stubbs on 3/04/12.
//  Copyright (c) 2012 Parallel ThirtyEight South. All rights reserved.
//

#import "IMSSearchDisplayController.h"

@implementation IMSSearchDisplayController

-(UITableView *) searchResultsTableView 
{
    if (
    [self setValue:[NSNumber numberWithInt:UITableViewStyleGrouped]
        forKey:@"_searchResultsTableViewStyle"];
    return [super searchResultsTableView];
}

@end
