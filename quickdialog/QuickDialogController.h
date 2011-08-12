//
//  Created by escoz on 7/7/11.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class RootElement;


@interface QuickDialogController : UITableViewController {

@private
    RootElement *_root;
    id <UITableViewDataSource> _dataSource;
    id <UITableViewDelegate> _delegate;

    void (^_willDisappearCallback)(void);

}

@property(nonatomic, retain) RootElement * root;
@property(nonatomic, retain) void (^willDisappearCallback)();

- (void)loadView;

- (QuickDialogController *)initWithRoot:(RootElement *)rootElement;

- (void)displayViewController:(UIViewController *)newController;

- (void)displayViewControllerForRoot:(RootElement *)element;

+ (QuickDialogController *)controllerForRoot:(RootElement *)element;

+ (UINavigationController *)controllerWithNavigationForRoot:(RootElement *)root;

@end