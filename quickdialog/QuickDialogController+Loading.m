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

@implementation QuickDialogController (Loading)

- (UIView *)createLoadingView {
    
    UIView *loading = [[UIView alloc] init];
    loading.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    loading.frame = CGRectMake(0, 0, self.tableView.frame.size.width, self.tableView.frame.size.height);
    loading.tag = 1123002;
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [activity startAnimating];
    [activity sizeToFit];
    activity.center = CGPointMake(loading.center.x, loading.frame.size.height/3);
    [loading addSubview:activity];

    [self.tableView.superview addSubview:loading];
    [self.tableView.superview bringSubviewToFront:loading];
    return loading;
}


- (void)loading:(BOOL)visible {
   UIView *loadingView = [self.tableView.superview viewWithTag:1123002];
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