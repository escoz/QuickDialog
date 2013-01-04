#import "QuickDialogController+Navigation.h"
#import "QRootBuilder.h"
#import "QuickDialog.h"

@implementation QuickDialogController(Navigation)



- (void)displayViewController:(UIViewController *)newController {
    if (self.navigationController != nil ){
        [self.navigationController pushViewController:newController animated:YES];
    } else {
#ifdef __IPHONE_6_0
        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:newController] animated:YES completion:NULL];
#else
        [self presentModalViewController:[[UINavigationController alloc] initWithRootViewController:newController] animated:YES];
#endif
    }
}

- (void)displayViewControllerForRoot:(QRootElement *)root {
    QuickDialogController *newController = [self controllerForRoot: root];

    if (root.presentationMode==QPresentationModeNormal) {
        [self displayViewController:newController];
    } else if (root.presentationMode == QPresentationModePopover || root.presentationMode == QPresentationModeNavigationInPopover) {
        [self displayViewControllerInPopover:newController withNavigation:root.presentationMode==QPresentationModeNavigationInPopover];
    } else if (root.presentationMode == QPresentationModeModalForm) {
        UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController :newController];
        newController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStyleDone target:self action:@selector(dismissModalViewController)];
        navigation.modalPresentationStyle = UIModalPresentationFormSheet;
#ifdef __IPHONE_6_0
        [self presentViewController:navigation animated:YES completion:NULL];
#else
        [self presentModalViewController:navigation animated:YES];
#endif
    }  else if (root.presentationMode == QPresentationModeModalFullScreen) {
        UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController :newController];
        newController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStyleDone target:self action:@selector(dismissModalViewController)];
        navigation.modalPresentationStyle = UIModalPresentationFullScreen;
#ifdef __IPHONE_6_0
        [self presentViewController:navigation animated:YES completion:NULL];
#else
        [self presentModalViewController:navigation animated:YES];
#endif
    }  else if (root.presentationMode == QPresentationModeModalPage) {
        UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController :newController];
        newController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStyleDone target:self action:@selector(dismissModalViewController)];
        navigation.modalPresentationStyle = UIModalPresentationPageSheet;
#ifdef __IPHONE_6_0
        [self presentViewController:navigation animated:YES completion:NULL];
#else
        [self presentModalViewController:navigation animated:YES];
#endif
    }
}

- (void)dismissModalViewController {
#ifdef __IPHONE_6_0
    [self dismissViewControllerAnimated:YES completion:NULL];
#else
    [self dismissModalViewControllerAnimated:YES];
#endif

}

- (void)displayViewControllerInPopover:(UIViewController *)newController withNavigation:(BOOL)navigation fromRect:(CGRect)position {

    if ([UIDevice currentDevice].userInterfaceIdiom!=UIUserInterfaceIdiomPad){
        [self displayViewController:newController];
        return;
    }

    UIPopoverController *popoverController = [[UIPopoverController alloc] initWithContentViewController:
        navigation ? [[UINavigationController alloc] initWithRootViewController :newController] : newController
    ];
    popoverController.popoverContentSize = CGSizeMake(320, 360);
    if ([newController respondsToSelector:@selector(setPopoverBeingPresented:)]) {
        [newController performSelector:@selector(setPopoverBeingPresented:) withObject:popoverController];
    } else {
        self.popoverForChildRoot = popoverController;
    }
    popoverController.delegate = self;

    [popoverController presentPopoverFromRect:position inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (void)displayViewControllerInPopover:(UIViewController *)newController withNavigation:(BOOL)navigation {

    CGRect position = [self.quickDialogTableView rectForRowAtIndexPath:self.quickDialogTableView.indexPathForSelectedRow];
    [self displayViewControllerInPopover:newController withNavigation:navigation fromRect:position];
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    [self.quickDialogTableView reloadData];
    self.popoverForChildRoot = nil;

}


- (void)popToPreviousRootElementOnMainThread {

    if ([self popoverBeingPresented]!=nil){
        [self.popoverBeingPresented dismissPopoverAnimated:YES];
        if (self.popoverBeingPresented.delegate!=nil){
            [self.popoverBeingPresented.delegate popoverControllerDidDismissPopover:self.popoverBeingPresented];
        }
    }
    else if (self.navigationController!=nil){
        [self.navigationController popViewControllerAnimated:YES];
    } else {
#ifdef __IPHONE_6_0
		[self dismissViewControllerAnimated:YES completion:NULL];
#else
		[self dismissModalViewControllerAnimated:YES];
#endif
    }
}

- (void)popToPreviousRootElement {
    [self performSelectorOnMainThread:@selector(popToPreviousRootElementOnMainThread) withObject:nil waitUntilDone:YES];
}

@end
