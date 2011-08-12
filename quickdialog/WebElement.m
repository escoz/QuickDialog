//
//  Created by escoz on 7/12/11.
//
//  To change this template use File | Settings | File Templates.
//


#import "Element.h"
#import "RootElement.h"
#import "WebElement.h"
#import "QuickDialogController.h"
#import "WebViewController.h"
#import "QuickDialogTableView.h"


@implementation WebElement

- (WebElement *)initWithTitle:(NSString *)title url:(NSString *)url {

    self = [super init];
    if (self!=nil){
        _url = url;
        _title = title;
    }
    return self;
}


- (void)selected:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller indexPath:(NSIndexPath *)path {
    WebViewController *webController = [[WebViewController alloc] initWithUrl:_url];
    [controller displayViewController:webController];

}
@end