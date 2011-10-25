//
//  QListPickerTableViewCell.h
//  ZipMark
//
//  Created by Paul Newman on 9/26/11.
//  Copyright (c) 2011 Newman Zone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "QEntryTableViewCell.h"


@interface QListPickerTableViewCell : QEntryTableViewCell <UIActionSheetDelegate, UIPickerViewDelegate, UIPickerViewDataSource>
{
    UIPickerView *_pickerView;
    NSMutableArray *list;

@private
    UILabel *_centeredLabel;
    
}

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, retain) NSArray *list;
@property (nonatomic, retain) UILabel *centeredLabel;


@end
