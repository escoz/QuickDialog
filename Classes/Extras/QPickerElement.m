#import "QPickerElement.h"
#import "QPickerTableViewCell.h"
#import "QPickerTabDelimitedStringParser.h"

@implementation QPickerElement
{
@private
    NSArray *_items;
    
    UIPickerView *_pickerView;
}

@synthesize items = _items;
@synthesize valueParser = _valueParser;

- (QPickerElement *)init
{
    if (self = [super init]) {
        self.valueParser = [QPickerTabDelimitedStringParser new];
        self.keepSelected = YES;
    }
    return self;
}

- (QPickerElement *)initWithTitle:(NSString *)title items:(NSArray *)items value:(id)value
{
    if ((self = [super initWithTitle:title Value:value])) {
        _items = items;
        self.valueParser = [QPickerTabDelimitedStringParser new];
    }
    return self;
}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller
{
    QPickerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:QPickerTableViewCellIdentifier];
    if (cell == nil) {
        cell = [[QPickerTableViewCell alloc] init];
    }
    [cell applyAppearanceForElement:self];

    UIPickerView *pickerView = nil;
    [cell prepareForElement:self inTableView:tableView pickerView:&pickerView];
    _pickerView = pickerView;
    
    cell.imageView.image = self.image;
    
    return cell;
}

- (void)fetchValueIntoObject:(id)obj
{
	if (_key != nil) {
        [obj setValue:_value forKey:_key];
    }
}

- (NSArray *)selectedIndexes
{
    NSMutableArray *selectedIndexes = [NSMutableArray arrayWithCapacity:_pickerView.numberOfComponents];
    for (int component = 0; component < _pickerView.numberOfComponents; component++) {
        [selectedIndexes addObject:[NSNumber numberWithInteger:[_pickerView selectedRowInComponent:component]]];
    }
    return selectedIndexes;
}

- (void)reloadAllComponents
{
    [_pickerView reloadAllComponents];
}

- (void)reloadComponent:(NSInteger)index
{
    [_pickerView reloadComponent:index];
}
@end
