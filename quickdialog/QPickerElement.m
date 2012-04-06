#import "QPickerElement.h"
#import "QPickerTableViewCell.h"
#import "QPickerWhitespaceDelimitedStringParser.h"

@implementation QPickerElement
{
@private
    NSArray *_componentsOptions;
    void (^_onValueChanged)();
}

@synthesize componentsOptions = _componentsOptions;
@synthesize valueParser = _valueParser;
@synthesize onValueChanged = _onValueChanged;

- (QPickerElement *)initWithTitle:(NSString *)title componentsOptions:(NSArray *)componentsOptions value:(NSString *)value
{
    if (self = [super initWithTitle:title Value:value]) {
        _componentsOptions = componentsOptions;
        self.valueParser = [QPickerWhitespaceDelimitedStringParser new];
    }
    return self;
}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller
{
    QPickerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:QPickerTableViewCellIdentifier];
    if (cell == nil) {
        cell = [[QPickerTableViewCell alloc] init];
    }
    
    [cell prepareForElement:self inTableView:tableView];
    cell.imageView.image = self.image;
    
    return cell;
}

- (void)fetchValueIntoObject:(id)obj
{
	if (_key != nil) {
        [obj setValue:_value forKey:_key];
    }
}

@end