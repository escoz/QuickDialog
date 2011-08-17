//
//  Created by escoz on 7/12/11.
//
//  To change this template use File | Settings | File Templates.
//


#import "QElement.h"
#import "QRootElement.h"
#import "QWebElement.h"
#import "QuickDialogController.h"
#import "QWebViewController.h"
#import "QuickDialogTableView.h"


@implementation QWebElement

- (QWebElement *)initWithTitle:(NSString *)title url:(NSString *)url {

    self = [super init];
    if (self!=nil){
        _url = url;
        _title = title;
    }
    return self;
}


- (void)selected:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller indexPath:(NSIndexPath *)path {
    QWebViewController *webController = [[QWebViewController alloc] initWithUrl:_url];
    [controller displayViewController:webController];

}
@end