//                                
// Copyright 2011 ESCOZ Inc  - http://escoz.com
// 
// Licensed under the Apache License, Version 2.0 (the "License"); you may not use this 
// file except in compliance with the License. You may obtain a copy of the License at 
// 
// http://www.apache.org/licenses/LICENSE-2.0 
// 
// Unless required by applicable law or agreed to in writing, software distributed under
// the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF 
// ANY KIND, either express or implied. See the License for the specific language governing
// permissions and limitations under the License.
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