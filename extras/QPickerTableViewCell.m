//
//  QPickerTableViewCell.m
//  QuickDialog
//
//  Created by HiveHicks on 05.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "QPickerTableViewCell.h"
#import "QuickDialog.h"

NSString * const QPickerTableViewCellIdentifier = @"QPickerTableViewCell";

@interface QPickerTableViewCell ()
@property (nonatomic, readonly) QPickerElement *pickerElement;
@end

@implementation QPickerTableViewCell

@synthesize pickerView = _pickerView;

- (QPickerTableViewCell *)init
{
    if ((self = [self initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:QPickerTableViewCellIdentifier]))
    {
        [self createSubviews];
		self.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
    
    return self;
}

- (void)createSubviews
{
    [super createSubviews];
    _textField.hidden = YES;
}

- (QPickerElement *)pickerElement
{
    return (QPickerElement *)_entryElement;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [super textFieldDidEndEditing:textField];
    self.selected = NO;  
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [_pickerView sizeToFit];
    
    _textField.inputView = _pickerView;
    
    if (self.pickerElement.value != nil) {
        [self setPickerViewValue:self.pickerElement.value];
    }
    
    [super textFieldDidBeginEditing:textField];
    self.selected = YES;
}

- (void)prepareForElement:(QEntryElement *)element inTableView:(QuickDialogTableView *)tableView pickerView:(UIPickerView **)pickerView
{
    [self prepareForElement:element inTableView:tableView];
    
    _pickerView = [[UIPickerView alloc] init];
    _pickerView.showsSelectionIndicator = YES;
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
    
    *pickerView = _pickerView;
}

- (void)prepareForElement:(QEntryElement *)element inTableView:(QuickDialogTableView *)tableView
{
    [super prepareForElement:element inTableView:tableView];
    
    QPickerElement *pickerElement = (QPickerElement *)element;

    if ([pickerElement.valueParser respondsToSelector:@selector(presentationOfObject:)]) {
        self.detailTextLabel.text = [pickerElement.valueParser presentationOfObject:pickerElement.value];
        _textField.text = [pickerElement.valueParser presentationOfObject:pickerElement.value];
    } else {
        self.detailTextLabel.text = [pickerElement.value description];
        _textField.text = [pickerElement.value description];
    }
    
    [self setNeedsLayout];
}

#pragma mark - UIPickerView data source and delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.pickerElement.items.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [[self.pickerElement.items objectAtIndex:(NSUInteger) component] count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [[[self.pickerElement.items objectAtIndex:(NSUInteger) component] objectAtIndex:(NSUInteger) row] description];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [self.pickerElement handleEditingChanged];

    self.pickerElement.value = [self getPickerViewValue];
    [self prepareForElement:_entryElement inTableView:_quickformTableView];
}

#pragma mark - Getting/setting value from UIPickerView

- (id)getPickerViewValue
{
    NSMutableArray *componentsValues = [NSMutableArray array];
    
    for (int i = 0; i < _pickerView.numberOfComponents; i++)
    {
        NSInteger rowIndex = [_pickerView selectedRowInComponent:i];
        if (rowIndex >= 0) {
            [componentsValues addObject:[self pickerView:_pickerView titleForRow:rowIndex forComponent:i]];
        } else {
            [componentsValues addObject:[NSNull null]];
        }
    }

    NSLog(@"AA%@", [self.pickerElement.valueParser objectFromComponentsValues:componentsValues]);
    return [self.pickerElement.valueParser objectFromComponentsValues:componentsValues];
}

- (void)setPickerViewValue:(id)value
{
    NSArray *componentsValues = [self.pickerElement.valueParser componentsValuesFromObject:value];
    
    for (int componentIndex = 0; componentIndex < componentsValues.count && componentIndex < _pickerView.numberOfComponents; componentIndex++)
    {
        id componentValue = [componentsValues objectAtIndex:(NSUInteger) componentIndex];
        NSInteger rowIndex = [[self.pickerElement.items objectAtIndex:componentIndex] indexOfObject:componentValue];
        if (rowIndex != NSNotFound) {
            [_pickerView selectRow:rowIndex inComponent:componentIndex animated:YES];
        }
    }
}

@end
