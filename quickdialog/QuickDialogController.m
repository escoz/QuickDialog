//
//  Created by escoz on 7/7/11.
//

#import "QuickDialogController.h"
#import "QRootElement.h"
#import "QuickDialogTableView.h"

@implementation QuickDialogController

@synthesize root = _root;
@synthesize willDisappearCallback = _willDisappearCallback;

- (void)loadView {
    [super loadView];
    QuickDialogTableView *quickformTableView = [[QuickDialogTableView alloc] initWithController:self];
    self.tableView = quickformTableView;
}

- (QuickDialogController *)initWithRoot:(QRootElement *)rootElement {
    self = [super init];
    if (self) {
         _root = rootElement;
    }
    return self;
}

- (void)setRoot:(QRootElement *)root {
    _root = root;
    ((QuickDialogTableView *)self.tableView).root = root;   
    self.title = _root.title;
}

- (void)viewWillAppear:(BOOL)animated {

    [((QuickDialogTableView *)self.tableView) viewWillAppear];
    [super viewWillAppear:animated];
    self.title = _root.title;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (_willDisappearCallback!=nil){
        _willDisappearCallback();
    }
}

- (void)popToPreviousRootElement {
    if (self.navigationController!=nil){
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissModalViewControllerAnimated:YES];
    }
}

- (void)displayViewController:(UIViewController *)newController {
    if (self.navigationController != nil ){
        [self.navigationController pushViewController:newController animated:YES];
    } else {
        [self presentModalViewController:newController animated:YES];
    }
}

- (void)displayViewControllerForRoot:(QRootElement *)root {

    QuickDialogController * newController = [QuickDialogController controllerForRoot:root];
    [self displayViewController:newController];
}

+ (QuickDialogController *)controllerForRoot:(QRootElement *)root {
    Class controllerClass = nil;
    if (root.controllerName!=NULL){
        controllerClass = NSClassFromString(root.controllerName);
    } else {
        controllerClass = [self class];
    }
    return [((QuickDialogController *)[controllerClass alloc]) initWithRoot:root];
}

+ (UINavigationController*)controllerWithNavigationForRoot:(QRootElement *)root {
    return [[UINavigationController alloc] initWithRootViewController:[QuickDialogController controllerForRoot:root]];
}

@end