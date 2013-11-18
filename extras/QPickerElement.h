#import <Foundation/Foundation.h>
#import "QEntryElement.h"
#import "QPickerValueParser.h"

@interface QPickerElement : QEntryElement
{
@protected
    id<QPickerValueParser> _valueParser;
}

@property (nonatomic, strong) id<QPickerValueParser> valueParser;

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) NSArray *itemsValues;
@property (nonatomic, readonly) NSArray *selectedIndexes;

@property (nonatomic, strong) id displayValue;
@property (nonatomic, strong) id submitValue;

- (QPickerElement *)initWithTitle:(NSString *)title items:(NSArray *)items value:(id)value;
- (QPickerElement *)initWithTitle:(NSString *)title items:(NSArray *)items itemsValues:(NSArray *) itemsValues value:(id)value;

- (void)reloadAllComponents;
- (void)reloadComponent:(NSInteger)index;


@end
