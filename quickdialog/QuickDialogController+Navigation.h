#import <Foundation/Foundation.h>

@interface QuickDialogController(Navigation)

- (void)displayViewController:(UIViewController *)newController;

- (void)displayViewControllerForRoot:(QRootElement *)element;

- (void)displayViewControllerInPopover:(UIViewController *)newController withNavigation:(BOOL)navigation fromRect:(CGRect)position;

- (void)displayViewControllerInPopover:(UIViewController *)newController withNavigation:(BOOL)navigation;

@end
