//
//  Created by escoz on 7/7/11.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class QRootElement;


@interface QuickDialogController : UITableViewController {

@private
    QRootElement *_root;
    id <UITableViewDataSource> _dataSource;
    id <UITableViewDelegate> _delegate;

    void (^_willDisappearCallback)(void);

}

@property(nonatomic, retain) QRootElement * root;
@property(nonatomic, retain) void (^willDisappearCallback)();

- (void)loadView;

- (QuickDialogController *)initWithRoot:(QRootElement *)rootElement;

- (void)displayViewController:(UIViewController *)newController;

- (void)displayViewControllerForRoot:(QRootElement *)element;

+ (QuickDialogController *)controllerForRoot:(QRootElement *)element;

+ (UINavigationController *)controllerWithNavigationForRoot:(QRootElement *)root;

@end