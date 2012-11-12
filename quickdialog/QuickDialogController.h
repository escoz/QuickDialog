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

#import "QuickDialogTableView.h"

@interface QuickDialogController : UIViewController <UIPopoverControllerDelegate> {

@private
    QRootElement *_root;
    id <UITableViewDataSource> _dataSource;
    id <UITableViewDelegate> _delegate;
    QuickDialogTableView * _quickDialogTableView;

    void (^_willDisappearCallback)(void);

}

@property(nonatomic, retain) QRootElement * root;
@property(nonatomic, copy) void (^willDisappearCallback)();
@property(nonatomic, strong) QuickDialogTableView *quickDialogTableView;
@property(nonatomic) BOOL resizeWhenKeyboardPresented;


@property(nonatomic, strong) UIPopoverController *popoverBeingPresented;

- (void)loadView;

- (QuickDialogController *)initWithRoot:(QRootElement *)rootElement;

- (void)displayViewController:(UIViewController *)newController;

- (void)displayViewControllerForRoot:(QRootElement *)element;

- (void)displayViewControllerInPopover:(QuickDialogController *)newController withNavigation:(BOOL)navigation;


- (QuickDialogController *)controllerForRoot:(QRootElement *)root;

+ (QuickDialogController *)controllerForRoot:(QRootElement *)root;

+ (UINavigationController *)controllerWithNavigationForRoot:(QRootElement *)root;

@end
