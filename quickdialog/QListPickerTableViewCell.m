//
//  QListPickerTableViewCell.m
//  ZipMark
//
//  Created by Paul Newman on 9/26/11.
//  Copyright (c) 2011 Newman Zone. All rights reserved.
//

#import "QListPickerTableViewCell.h"
#import "QListPickerInlineElement.h"

@implementation QListPickerTableViewCell

@synthesize pickerView = _pickerView;
@synthesize centeredLabel = _centeredLabel;
@synthesize list;

- (QListPickerTableViewCell *)init {
    self = [self initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"QuickformListPickerInlineElement"];
    if (self!=nil){
        [self createSubviews];
		self.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    return self;
}


- (void)createSubviews {
    [super createSubviews];
    
    _textField.hidden = YES;
    
    _pickerView = [[UIPickerView alloc] init];
    [_pickerView sizeToFit];
    _pickerView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    [_pickerView setShowsSelectionIndicator:YES];
    [_pickerView setDataSource:self];
    [_pickerView setDelegate:self];
    
    _textField.inputView = _pickerView;
    
    self.centeredLabel = [[UILabel alloc] init];
    self.centeredLabel.textColor = [UIColor colorWithRed:0.243 green:0.306 blue:0.435 alpha:1.0];
    self.centeredLabel.highlightedTextColor = [UIColor whiteColor];
    self.centeredLabel.font = [UIFont systemFontOfSize:17];
    self.centeredLabel.textAlignment = UITextAlignmentCenter;
	self.centeredLabel.backgroundColor = [UIColor clearColor];
    self.centeredLabel.frame = CGRectMake(10, 10, self.contentView.frame.size.width-20, self.contentView.frame.size.height-20);
    [self.contentView addSubview:self.centeredLabel];
}


- (void)prepareForElement:(QEntryElement *)element inTableView:(QuickDialogTableView *)tableView {
    [super prepareForElement:element inTableView:tableView];
    
    QListPickerInlineElement *entry = (QListPickerInlineElement *)element;
    
    if (!entry.centerLabel){
		self.textLabel.text = element.title;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.centeredLabel.text = nil;
		self.detailTextLabel.text = entry.selectedItem;
		
    } else {
        self.selectionStyle = UITableViewCellSelectionStyleBlue;
        self.textLabel.text = nil;
		self.centeredLabel.text = entry.selectedItem;
    }
	
	_textField.text = entry.selectedItem;
    _textField.placeholder = entry.placeholder;    
    _textField.inputAccessoryView.hidden = entry.hiddenToolbar;
}


#pragma mark - UIPickerViewDelegate methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView 
{ 
    // How many columns will be used in the UIPickerView
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component 
{ 
    // How many rows the UIPickerView will have
	return [list count];
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component 
{ 
    // What is the label of each row
	return [list objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component 
{ 
    ((QListPickerInlineElement *)_entryElement).selectedItem = [list objectAtIndex:row];
    ((QListPickerInlineElement *)_entryElement).selectedIndex = row;
    [self prepareForElement:_entryElement inTableView:_quickformTableView];
}

@end
