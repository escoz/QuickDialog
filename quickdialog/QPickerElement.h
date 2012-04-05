#import <Foundation/Foundation.h>
#import "QEntryElement.h"
#import "QPickerValueParser.h"

@interface QPickerElement : QEntryElement
{
@protected
    id<QPickerValueParser> _valueParser;
}

@property (nonatomic, readonly) NSArray *componentsOptions;
@property (nonatomic, strong) id<QPickerValueParser> valueParser;
@property (nonatomic, copy) void (^onValueChanged)(void);

- (QPickerElement *)initWithTitle:(NSString *)title componentsOptions:(NSArray *)componentsOptions value:(id)value;

@end