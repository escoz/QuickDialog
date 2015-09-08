//
//  QPickerTableViewCell.h
//  QuickDialog
//
//  Created by HiveHicks on 05.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "QEntryTableViewCell.h"

@interface QPickerTableViewCell : QEntryTableViewCell <UIPickerViewDataSource, UIPickerViewDelegate>
{
    UIPickerView *_pickerView;
}

@property (nonatomic, strong) UIPickerView *pickerView;

- (void)prepareForElement:(QEntryElement *)element inTableView:(QuickDialogTableView *)tableView pickerView:(UIPickerView **)pickerView;

- (void)setPickerViewValue:(id)value;
- (id)getPickerViewValue;

@end
