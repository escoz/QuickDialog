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
@interface QuickDialogController ()

+ (Class)controllerClassForRoot:(QRootElement *)root;

@end


@implementation QuickDialogController {
    BOOL _keyboardVisible;
    BOOL _viewOnScreen;
    BOOL _resizeWhenKeyboardPresented;
    UIPopoverController *_popoverForChildRoot;
}

@synthesize root = _root;
@synthesize willDisappearCallback = _willDisappearCallback;
@synthesize quickDialogTableView = _quickDialogTableView;
@synthesize resizeWhenKeyboardPresented = _resizeWhenKeyboardPresented;
@synthesize popoverBeingPresented = _popoverBeingPresented;
@synthesize popoverForChildRoot = _popoverForChildRoot;


+ (QuickDialogController *)buildControllerWithClass:(Class)controllerClass root:(QRootElement *)root {
    controllerClass = controllerClass==nil? [QuickDialogController class] : controllerClass;
    return [((QuickDialogController *)[controllerClass alloc]) initWithRoot:root];
}

+ (QuickDialogController *)controllerForRoot:(QRootElement *)root {
    Class controllerClass = [self controllerClassForRoot:root];
    if (controllerClass==nil)
        NSLog(@"Couldn't find a class for name %@", root.controllerName);
    return [((QuickDialogController *)[controllerClass alloc]) initWithRoot:root];
}


+ (Class)controllerClassForRoot:(QRootElement *)root {
    Class controllerClass = nil;
    if (root.controllerName!=NULL){
        controllerClass = NSClassFromString(root.controllerName);
    } else {
        controllerClass = [QuickDialogController class];
    }
    return controllerClass;
}

+ (UINavigationController*)controllerWithNavigationForRoot:(QRootElement *)root {
    return [[UINavigationController alloc] initWithRootViewController:[QuickDialogController
                                                                       buildControllerWithClass:[self controllerClassForRoot:root]
                                                                       root:root]];
}

- (void)loadView {
    [super loadView];
    self.quickDialogTableView = [[QuickDialogTableView alloc] initWithController:self];
}

- (void)setQuickDialogTableView:(QuickDialogTableView *)tableView
{
    _quickDialogTableView = tableView;
    self.view = tableView;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (QuickDialogController *)initWithRoot:(QRootElement *)rootElement {
    self = [super init];
    if (self) {
        self.root = rootElement;
        self.resizeWhenKeyboardPresented =YES;
    }
    return self;
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [self.quickDialogTableView setEditing:editing animated:animated];
}

- (void)setRoot:(QRootElement *)root {
    _root = root;
    self.quickDialogTableView.root = root;
    self.title = _root.title;
    self.navigationItem.title = _root.title;
}

- (void)viewWillAppear:(BOOL)animated {
    _viewOnScreen = YES;
    [self.quickDialogTableView deselectRows];
    [super viewWillAppear:animated];
    if (_root!=nil) {
        self.title = _root.title;
        self.navigationItem.title = _root.title;
        if (_root.preselectedElementIndex !=nil)
            [self.quickDialogTableView scrollToRowAtIndexPath:_root.preselectedElementIndex atScrollPosition:UITableViewScrollPositionTop animated:NO];

    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    if (_root.showKeyboardOnAppear) {
        QEntryElement *elementToFocus = [_root findElementToFocusOnAfter:nil];
        if (elementToFocus!=nil)  {
            UITableViewCell *cell = [self.quickDialogTableView cellForElement:elementToFocus];
            if (cell != nil) {
                [cell becomeFirstResponder];
            }
        }
    }
}


- (BOOL)disablesAutomaticKeyboardDismissal
{
    return NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    _viewOnScreen = NO;
    [super viewWillDisappear:animated];
    if (_willDisappearCallback!=nil){
        _willDisappearCallback();
    }
}

- (QuickDialogController *)controllerForRoot:(QRootElement *)root {
    Class controllerClass = [[self class] controllerClassForRoot:root];
    return [QuickDialogController buildControllerWithClass:controllerClass root:root];
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    NSDictionary* userInfo = [notification userInfo];
    CGRect keyboardEndFrame;
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardEndFrame];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    if (CGRectIntersectsRect(keyboardEndFrame, screenRect)){
        //Our Keyboard is showing
        CGRect keyboardFrame = [self.view convertRect:keyboardEndFrame toView:nil];
        const UIEdgeInsets oldInset = self.quickDialogTableView.contentInset;
        
        //Compensate for padding on split keyboard
        CGFloat totalHeight = (keyboardFrame.size.height + 20.0f);        
        self.quickDialogTableView.contentInset = UIEdgeInsetsMake(oldInset.top, oldInset.left, totalHeight, oldInset.right);
        
    } else {
       //Keyboard is hidden
        [UIView animateWithDuration:animationDuration delay:0 options:animationCurve
                         animations:^{
                             const UIEdgeInsets oldInset = self.quickDialogTableView.contentInset;
                             self.quickDialogTableView.contentInset = UIEdgeInsetsMake(oldInset.top, oldInset.left,  0, oldInset.right);
                         }
                         completion:NULL];
    }
}

- (void)setResizeWhenKeyboardPresented:(BOOL)observesKeyboard {
    if (observesKeyboard != _resizeWhenKeyboardPresented) {
        _resizeWhenKeyboardPresented = observesKeyboard;
        
        if (_resizeWhenKeyboardPresented) {
            
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification              object:nil];
        } else {
            
            [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
        }
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}


@end
