//
//  Created by escoz on 7/12/11.
//

#import <Foundation/Foundation.h>

@class RootElement;
@class QuickDialogTableView;

@interface WebElement : RootElement {

@protected
    NSString *_url;
}

- (WebElement *)initWithTitle:(NSString *)title url:(NSString *)url;

- (void)selected:(QuickDialogTableView *)tableView controller:(QuickDialogTableView *)controller indexPath:(NSIndexPath *)path;

@end