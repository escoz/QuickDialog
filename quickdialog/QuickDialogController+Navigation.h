#import <Foundation/Foundation.h>
#import "QuickDialog.h"
#import "QRootElement.h"

@class QRootElement;
@interface QuickDialogController(Navigation)

- (void)displayViewController:(UIViewController *)newController;

- (void)displayViewController:(UIViewController *)newController withPresentationMode:(QPresentationMode)mode;

- (void)displayViewControllerForRoot:(QRootElement *)element;

- (void)dismissModalViewController;

- (void)displayViewControllerInPopover:(UIViewController *)newController withNavigation:(BOOL)navigation fromRect:(CGRect)position;

- (void)displayViewControllerInPopover:(UIViewController *)newController withNavigation:(BOOL)navigation;

- (void)popToPreviousRootElement;


@end
