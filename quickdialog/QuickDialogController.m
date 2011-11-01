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


@interface QuickDialogController ()

+ (Class)controllerClassForRoot:(QRootElement *)root;

@end


@implementation QuickDialogController

@synthesize root = _root;
@synthesize willDisappearCallback = _willDisappearCallback;

- (void)loadView {
    [super loadView];
    QuickDialogTableView *quickformTableView = [[QuickDialogTableView alloc] initWithController:self];
    self.tableView = quickformTableView;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
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
    self.navigationItem.title = _root.title;
}

- (void)viewWillAppear:(BOOL)animated {

    [((QuickDialogTableView *)self.tableView) viewWillAppear];
    [super viewWillAppear:animated];
    if (_root!=nil)
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
    QuickDialogController *newController = [self controllerForRoot: root];
    [self displayViewController:newController];
}

+ (QuickDialogController *)buildControllerWithClass:(Class)controllerClass root:(QRootElement *)root {
    controllerClass = controllerClass==nil? [QuickDialogController class] : controllerClass;
    return [((QuickDialogController *)[controllerClass alloc]) initWithRoot:root];
}

- (QuickDialogController *)controllerForRoot:(QRootElement *)root {
    Class controllerClass = [[self class] controllerClassForRoot:root];
    return [QuickDialogController buildControllerWithClass:controllerClass root:root];
}


+ (QuickDialogController *)controllerForRoot:(QRootElement *)root {
    Class controllerClass = [self controllerClassForRoot:root];
    return [((QuickDialogController *)[controllerClass alloc]) initWithRoot:root];
}


+ (Class)controllerClassForRoot:(QRootElement *)root {
    Class controllerClass = nil;
    if (root.controllerName!=NULL){
        controllerClass = NSClassFromString(root.controllerName);
    } else {
        controllerClass = [self class];
    }
    return controllerClass;
}

+ (UINavigationController*)controllerWithNavigationForRoot:(QRootElement *)root {
    return [[UINavigationController alloc] initWithRootViewController:[QuickDialogController
                                                                       buildControllerWithClass:[self controllerClassForRoot:root]
                                                                       root:root]];
}

@end