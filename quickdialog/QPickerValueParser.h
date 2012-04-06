//
//  QPickerValueExtrator.h
//  QuickDialog
//
//  Created by HiveHicks on 05.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol QPickerValueParser <NSObject>

@required
- (id)objectFromComponentsValues:(NSArray *)componentsValues;
- (NSArray *)componentsValuesFromObject:(id)object;

@end
