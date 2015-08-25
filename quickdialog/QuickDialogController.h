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

#import "QElement.h"
#import "QuickDialogTableView.h"

@class QRootElement;
@class QuickDialogTableView;

/**
 QuickDialogController is a subclass of a UITableViewController that is responsible for actually displaying the dialog. For your application, you’ll very likely be creating subclasses of this class, one for each dialog you own. You’ll never really have to create objects of this type directly with alloc/init. The framework takes care of this for you.
 */

@interface QuickDialogController : UIViewController <UIPopoverControllerDelegate> {

@private
    QRootElement *_root;
    //    id <UITableViewDataSource> _dataSource;
    //    id <UITableViewDelegate> _delegate;
    QuickDialogTableView * _quickDialogTableView;

    void (^_willDisappearCallback)(void);

}

@property(nonatomic, retain) QRootElement * root;
@property(nonatomic, copy) void (^willDisappearCallback)();
@property(nonatomic, strong) QuickDialogTableView *quickDialogTableView;
@property(nonatomic) BOOL resizeWhenKeyboardPresented;


@property(nonatomic, strong) UIPopoverController *popoverBeingPresented;
@property(nonatomic, strong) UIPopoverController *popoverForChildRoot;


- (void)loadView;

- (QuickDialogController *)initWithRoot:(QRootElement *)rootElement;

- (QuickDialogController *)controllerForRoot:(QRootElement *)root;

+ (QuickDialogController *)controllerForRoot:(QRootElement *)root;

/**
 Called before a cell is removed from the tableView. Return YES and QuickDialog will delete the cell, return NO if you want to delete the cell or reload the tableView yourself.
*/
- (BOOL)shouldDeleteElement:(QElement *)element;

+ (UINavigationController *)controllerWithNavigationForRoot:(QRootElement *)root;


@end
