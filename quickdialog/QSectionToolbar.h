//
//  QSectionToolbar.h
//  QuickDialog
//
//  Created by Michael Kunz on 09.11.12.
//
//

#import <UIKit/UIKit.h>

@class QSection;

@interface QSectionToolbarItem : NSObject

@property (weak, readwrite) QSection * section;
@property (assign, readwrite, nonatomic) UIBarButtonSystemItem systemItem;
@property (retain, readwrite, nonatomic) NSString * controllerAction;
@property (assign, readwrite, nonatomic) BOOL enabled;
@property (strong, readwrite, nonatomic) UIImage * image;
@property (retain, readwrite, nonatomic) NSString * imageNamed;
@property (strong, readwrite, nonatomic) NSString * title;
@property (assign, readwrite, nonatomic) float width;

@end

@interface QSectionToolbar : UIToolbar

- (QSectionToolbar*) initWithElements: (NSArray*)elements controller:(QuickDialogController*)controller;


@end
