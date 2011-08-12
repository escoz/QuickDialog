//
//  Created by escoz on 7/26/11.
//

#import "QuickDialogController+Loading.h"

@implementation QuickDialogController (Loading)

- (UIView *)createLoadingView {
    UIView *loading = [[UIView alloc] init];
    loading.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    loading.frame = CGRectMake(0, 0, self.tableView.frame.size.width, self.tableView.frame.size.height);
    loading.tag = 1123002;
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [activity startAnimating];
    activity.center = CGPointMake(loading.center.x, loading.frame.size.height/3);
    [loading addSubview:activity];

    [self.view addSubview:loading];
    [self.view bringSubviewToFront:loading];
    return loading;
}


- (void)loading:(BOOL)visible {
   UIView *loadingView = [self.view viewWithTag:1123002];
    if (loadingView==nil){
        loadingView = [self createLoadingView];
    }

    self.tableView.userInteractionEnabled = !visible;

    if (visible)
        loadingView.hidden = NO;

    loadingView.alpha = visible ? 0 : 1;
    [UIView animateWithDuration:0.3
                     animations:^{
                          loadingView.alpha = visible ? 1 : 0;
                     }
                     completion: ^(BOOL  finished) {
                         if (!visible)
                              loadingView.hidden = YES;
                     }];
}
@end