//
//  Created by escoz on 1/7/12.
//
#import "JsonDataSampleController.h"

@implementation JsonDataSampleController

-(void)handleReloadJson:(QElement *)button {
    self.root = [[QRootElement alloc] initWithJSONFile:@"jsondatasample"];
}

-(void)handleLoadJsonWithDict:(QElement *)button {
    NSMutableDictionary *dataDict = [NSMutableDictionary new];
    [dataDict setValue:@"Yesterday" forKey:@"myDate"];
    [dataDict setValue:@"Midnight" forKey:@"myTime"];
    [dataDict setValue:@"When?" forKey:@"dateTitle"];
    [dataDict setValue:@"What time?" forKey:@"timeTitle"];
    [dataDict setValue:[NSNumber numberWithBool:YES] forKey:@"bool"];
    [dataDict setValue:[NSNumber numberWithFloat:0.4] forKey:@"float"];

    self.root = [[QRootElement alloc] initWithJSONFile:@"jsondatasample" andData:dataDict];
}

-(void)handleSetValuesDirectly:(QElement *)button {
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    QLabelElement *elDate = (QLabelElement *) [[self root] elementWithKey:@"date"];
    elDate.value = [dateFormatter stringFromDate:[NSDate date]];
    
    [dateFormatter setDateFormat:@"HH-mm-ss"];
    QLabelElement *elTime = (QLabelElement *) [[self root] elementWithKey:@"time"];
    elTime.value = [dateFormatter stringFromDate:[NSDate date]];

    [self.quickDialogTableView reloadCellForElements:elDate, elTime, nil];
    // if table is fairly small (10-100 items), you can just call [self.tableView reloadData]
}



@end