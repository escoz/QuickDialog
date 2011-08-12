//
//  Created by escoz on 7/28/11.
//
//  To change this template use File | Settings | File Templates.
//


#import "LoginController.h"
#import "AboutController.h"
#import "LoginController.h"


@implementation AboutController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated]; 
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStyleDone target:self action:@selector(close)];
}

- (void)close {
    [self dismissModalViewControllerAnimated:YES];
}


@end