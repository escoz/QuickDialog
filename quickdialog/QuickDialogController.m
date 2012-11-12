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
    [self.quickDialogTableView viewWillAppear];
    [super viewWillAppear:animated];
    if (_root!=nil)
        self.title = _root.title;
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


- (void) resizeForKeyboard:(NSNotification*)aNotification {
    if (!_viewOnScreen)
        return;

    BOOL up = aNotification.name == UIKeyboardWillShowNotification;

    if (_keyboardVisible == up)
        return;

    _keyboardVisible = up;
    NSDictionary* userInfo = [aNotification userInfo];
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    CGRect keyboardEndFrame;
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardEndFrame];

    [UIView animateWithDuration:animationDuration delay:0 options:animationCurve
        animations:^{
            CGRect keyboardFrame = [self.view convertRect:keyboardEndFrame toView:nil];
            const UIEdgeInsets oldInset = self.quickDialogTableView.contentInset;
            self.quickDialogTableView.contentInset = UIEdgeInsetsMake(oldInset.top, oldInset.left,  up ? keyboardFrame.size.height : 0, oldInset.right);
        }
        completion:NULL];
}

- (void)setResizeWhenKeyboardPresented:(BOOL)observesKeyboard {
  if (observesKeyboard != _resizeWhenKeyboardPresented) {
    _resizeWhenKeyboardPresented = observesKeyboard;

    if (_resizeWhenKeyboardPresented) {
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resizeForKeyboard:) name:UIKeyboardWillShowNotification object:nil];
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resizeForKeyboard:) name:UIKeyboardWillHideNotification object:nil];
    } else {
      [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
      [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    }
  }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}


- (void) hideElementsWithAnimation:(UITableViewRowAnimation)animation elements:(QElement*)element,...
{
    va_list args;
    va_start(args, element);
    [self hideElementsWithInsertAnimation:animation removeAnimation:animation elements:element args:args];
    va_end(args);
}
- (void) hideSectionsWithAnimation:(UITableViewRowAnimation)animation sections:(QSection*)section,...
{
    va_list args;
    va_start(args, section);
    [self hideSectionsWithInsertAnimation:animation removeAnimation:animation sections:section args:args];
    va_end(args);
}
- (void) hideElementsWithInsertAnimation:(UITableViewRowAnimation)insertAnimation removeAnimation:(UITableViewRowAnimation)removeAnimation elements:(QElement*)element,...
{
    va_list args;
    va_start(args, element);
    [self hideElementsWithInsertAnimation:insertAnimation removeAnimation:removeAnimation elements:element args:args];
    va_end(args);
}
- (void) hideSectionsWithInsertAnimation:(UITableViewRowAnimation)insertAnimation removeAnimation:(UITableViewRowAnimation)removeAnimation sections:(QSection*)section,...
{
    va_list args;
    va_start(args, section);
    [self hideSectionsWithInsertAnimation:insertAnimation removeAnimation:removeAnimation sections:section args:args];
    va_end(args);
}

- (void) hideElementsWithInsertAnimation:(UITableViewRowAnimation)insertAnimation removeAnimation:(UITableViewRowAnimation)removeAnimation elements:(QElement*)element args:(va_list)args
{
    NSMutableArray * idx = [NSMutableArray new];
    NSMutableArray * del = [NSMutableArray new];
    NSMutableArray * ins = [NSMutableArray new];
    
    while (element)
    {
        BOOL h = va_arg(args, /*BOOL*/int);
        if (h)
            [del addObject:element];
        else
            [ins addObject:element];
        element = va_arg(args, QElement*);
    }
    
    [self.quickDialogTableView beginUpdates];
    NSEnumerator * i = [del reverseObjectEnumerator];
    while ((element =/*=*/ i.nextObject))
    {
        if (!element.hidden)
        {
            [idx addObject:[NSIndexPath indexPathForRow:element.visibleIndex inSection:element.parentSection.visibleIndex]];
            element.hidden = YES;
        }
    }
    [self.quickDialogTableView deleteRowsAtIndexPaths:idx withRowAnimation:removeAnimation];
    
    [idx removeAllObjects];
    for (element in ins)
    {
        if (element.hidden)
        {
            element.hidden = NO;
            [idx addObject:[NSIndexPath indexPathForRow:element.visibleIndex inSection:element.parentSection.visibleIndex]];
        }
    }
    [self.quickDialogTableView insertRowsAtIndexPaths:idx withRowAnimation:insertAnimation];
    [self.quickDialogTableView endUpdates];
}

- (void) hideSectionsWithInsertAnimation:(UITableViewRowAnimation)insertAnimation removeAnimation:(UITableViewRowAnimation)removeAnimation sections:(QSection *)section args:(va_list)args
{
    NSMutableIndexSet * idx = [NSMutableIndexSet new];
    NSMutableArray * del = [NSMutableArray new];
    NSMutableArray * ins = [NSMutableArray new];
    while (section)
    {
        BOOL h = va_arg(args, /*BOOL*/int);
        if (h)
            [del addObject:section];
        else
            [ins addObject:section];
        section = va_arg(args, QSection*);
    }
    
    [self.quickDialogTableView beginUpdates];
    NSEnumerator * i = [del reverseObjectEnumerator];
    while ((section =/*=*/ i.nextObject))
    {
        if (!section.hidden)
        {
            [idx addIndex:section.visibleIndex];
            section.hidden = YES;
        }
    }
    [self.quickDialogTableView deleteSections:idx withRowAnimation:removeAnimation];
    
    [idx removeAllIndexes];
    for (section in ins)
    {
        if (section.hidden)
        {
            section.hidden = NO;
            [idx addIndex:section.visibleIndex];
        }
    }
    [self.quickDialogTableView insertSections:idx withRowAnimation:insertAnimation];
    [self.quickDialogTableView endUpdates];
}


@end
