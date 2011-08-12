//
//  Created by escoz on 7/7/11.
//
//  To change this template use File | Settings | File Templates.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class QuickDialogController;
@class QuickDialogTableView;


@interface QuickDialogDataSource : NSObject<UITableViewDataSource> {

@private
    QuickDialogTableView *_tableView;
}
- (id <UITableViewDataSource, NSObject>)initForTableView:(QuickDialogTableView *)view;

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;

@end