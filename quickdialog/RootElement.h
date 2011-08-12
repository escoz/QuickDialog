//
//  Created by escoz on 7/7/11.
//
//  To change this template use File | Settings | File Templates.
//


#import <Foundation/Foundation.h>

#import "Element.h"
@class Section;

@interface RootElement : Element {

@protected
	BOOL _grouped;
	
    NSString *_title;
    NSMutableArray *_sections;
    NSString *_controllerName;
}

@property(nonatomic, retain) NSString *title;
@property(nonatomic, strong) NSMutableArray *sections;
@property(assign) BOOL grouped;

@property(nonatomic, retain) NSString *controllerName;

- (void)addSection:(Section *)section;
- (Section *)getSectionForIndex:(NSInteger)index;
- (NSInteger)numberOfSections;


@end