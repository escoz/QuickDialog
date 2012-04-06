#import "QPickerElement.h"
#import "QPickerTableViewCell.h"
#import "QPickerWhitespaceDelimitedStringParser.h"

@implementation QPickerElement
{
@private
    NSArray *_items;
    void (^_onValueChanged)();
}

@synthesize items = _items;
@synthesize valueParser = _valueParser;
@synthesize onValueChanged = _onValueChanged;

-(QPickerElement *)init {
    self = [super init];
    self.valueParser = [QPickerWhitespaceDelimitedStringParser new];
    return self;
}

- (QPickerElement *)initWithTitle:(NSString *)title items:(NSArray *)items value:(NSString *)value
{
    if ((self = [super initWithTitle:title Value:value])) {
        _items = items;
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