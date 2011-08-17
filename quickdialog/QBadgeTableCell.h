//
//  Created by escoz on 7/13/11.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface QBadgeTableCell : UITableViewCell {

@private
    UIColor *_badgeColor;
    UILabel *_badgeLabel;
}
- (QBadgeTableCell *)init;


@property(nonatomic, retain) UIColor *badgeColor;
@property(nonatomic, readonly, strong) UILabel *badgeLabel;

@end