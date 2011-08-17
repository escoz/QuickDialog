//
//  Created by escoz on 7/12/11.
//

#import <Foundation/Foundation.h>

@class QRootElement;
@class QuickDialogTableView;

@interface QWebElement : QRootElement {

@protected
    NSString *_url;
}

- (QWebElement *)initWithTitle:(NSString *)title url:(NSString *)url;

- (void)selected:(QuickDialogTableView *)tableView controller:(QuickDialogTableView *)controller indexPath:(NSIndexPath *)path;

@end