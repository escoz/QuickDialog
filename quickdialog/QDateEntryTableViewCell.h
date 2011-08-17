//
//  Created by escoz on 7/15/11.
//
//  To change this template use File | Settings | File Templates.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class QEntryTableViewCell;


@interface QDateEntryTableViewCell : QEntryTableViewCell {

    UIDatePicker *_pickerView;
@private
    UILabel *_centeredLabel;
}
@property(nonatomic, strong) UIDatePicker *pickerView;

@property(nonatomic, retain) UILabel *centeredLabel;

@end