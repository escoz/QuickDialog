#import <Foundation/Foundation.h>
#import "QuickDialogController.h"
#import "QRootElement.h"

@interface QuickDialogController(Navigation)

- (void)displayViewController:(UIViewController *)newController;

- (void)displayViewControllerForRoot:(QRootElement *)element;

- (void)displayViewController: (UIViewController*) newController withPresentationMode:(QPresentationMode)presentationMode;

- (void)displayViewControllerInPopover:(UIViewController *)newController withNavigation:(BOOL)navigation fromRect:(CGRect)position;

- (void)displayViewControllerInPopover:(UIViewController *)newController withNavigation:(BOOL)navigation;

- (void)popToPreviousRootElement;


@end
