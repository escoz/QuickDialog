//
//  Created by escoz on 7/13/11.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface BadgeTableCell : UITableViewCell {

@private
    UIColor *_badgeColor;
    UILabel *_badgeLabel;
}
- (BadgeTableCell *)init;


@property(nonatomic, retain) UIColor *badgeColor;
@property(nonatomic, readonly, strong) UILabel *badgeLabel;

@end