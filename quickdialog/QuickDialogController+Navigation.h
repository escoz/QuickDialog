#import <Foundation/Foundation.h>

@interface QuickDialogController(Navigation)

- (void)displayViewController:(UIViewController *)newController;

- (void)displayViewControllerForRoot:(QRootElement *)element;

- (void)displayViewControllerInPopover:(UIViewController *)newController withNavigation:(BOOL)navigation;

@end
