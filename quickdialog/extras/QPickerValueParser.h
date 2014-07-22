//
//  QPickerValueExtrator.h
//  QuickDialog
//
//  Created by HiveHicks on 05.04.12.
//

#import <Foundation/Foundation.h>

@protocol QPickerValueParser <NSObject>

@required
- (id)objectFromComponentsValues:(NSArray *)componentsValues;
- (NSArray *)componentsValuesFromObject:(id)object;

@optional
- (NSString *)presentationOfObject:(id)object;

@end
