//
//  Created by escoz on 7/7/11.
//
//  To change this template use File | Settings | File Templates.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class QuickDialogController;
@class QuickDialogTableView;
@class QSection;


@interface QElement : NSObject {

@protected
    QSection *_parentSection;
    NSString *_key;

    void (^_onSelected)(void);
    NSString * _controllerAction;
}

@property(nonatomic, copy) void (^onSelected)(void);
@property(nonatomic, retain) NSString *controllerAction;


@property(nonatomic, retain) QSection *parentSection;

@property(nonatomic, retain) NSString *key;

- (QElement *)initWithKey:(NSString *)key;

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller;

- (void)selected:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller indexPath:(NSIndexPath *)indexPath;

- (CGFloat)getRowHeightForTableView:(QuickDialogTableView *)tableView;

- (void)fetchValueIntoObject:(id)obj;

@end