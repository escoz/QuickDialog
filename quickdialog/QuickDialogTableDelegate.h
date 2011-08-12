//
//  Created by escoz on 7/8/11.
//
//  To change this template use File | Settings | File Templates.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class QuickDialogController;
@class QuickDialogTableView;


@interface QuickDialogTableDelegate : NSObject<UITableViewDelegate> {

@private
    QuickDialogTableView *_tableView;
}

- (id<UITableViewDelegate, UIScrollViewDelegate>)initForTableView:(QuickDialogTableView *)tableView;

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath;


@end