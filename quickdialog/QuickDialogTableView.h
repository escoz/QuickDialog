//
//  Created by escoz on 7/9/11.
//
//  To change this template use File | Settings | File Templates.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class QuickDialogController;
@class RootElement;
@class Element;
@protocol QuickDialogStyleProvider;


@interface QuickDialogTableView : UITableView {


@private
    QuickDialogController *_controller;
    RootElement *_root;
    id <UITableViewDataSource> quickformDataSource;
    id <UITableViewDelegate> quickformDelegate;
    Element *_selectedElement;
    UITableViewCell *_selectedCell;
}

@property(nonatomic, retain) RootElement *root;

@property(nonatomic, readonly) QuickDialogController *controller;

@property(nonatomic, retain) UITableViewCell *selectedCell;

@property(nonatomic, retain) id<QuickDialogStyleProvider> styleProvider;

- (QuickDialogTableView *)initWithController:(QuickDialogController *)controller;

- (UITableViewCell *)cellForElement:(Element *)element;

- (void)viewWillAppear;
@end