//
//  QColorPickerElement.m
//  Color Picker
//
//  Created by Ben Wyatt on 10/7/12.
//  Copyright (c) 2012 Quickfire Software. All rights reserved.
//

#import "QColorPickerElement.h"
#import "UIColor+ColorUtilities.h"

@implementation QColorPickerElement {
    QSection *_internalRadioItemsSection;
}


- (QColorPickerElement *)init {
    self = [super init];
    if (self) {
        self.items = @[
                @[@"Black", [UIColor blackColor]],
                @[@"White", [UIColor whiteColor]],
                @[@"Gray", [UIColor grayColor]],
                @[@"Blue",  [UIColor blueColor]],
                @[@"Red",  [UIColor redColor]],
                @[@"Green", [UIColor greenColor]],
                @[@"Yellow", [UIColor yellowColor]],
                @[@"Purple", [UIColor purpleColor]],
                @[@"Magenta", [UIColor magentaColor]]
        ];
        self.selected = 0;
    }
    return self;
}

- (void)updateCell:(QEntryTableViewCell *)cell selectedValue:(id)selectedValue {
    self.image = [self getImageFromItem:selectedValue];
    [super updateCell:cell selectedValue:selectedValue];
    if (self.title == NULL){
        cell.textField.text = [[selectedValue objectAtIndex:0] description];
        cell.detailTextLabel.text = nil;
        cell.textField.textAlignment = self.appearance.labelAlignment;
    } else {
        cell.textLabel.text = _title;
        cell.textField.text = [[selectedValue objectAtIndex:0] description];
        cell.textField.textAlignment = self.appearance.valueAlignment;
    }
}

- (UIImage *)getImageFromItem:(NSArray *)selectedValue {
    id color = [selectedValue objectAtIndex:1];
    if ([color isKindOfClass:[UIColor class]])
        return [color imageByDrawingCircleOfColor];
    if ([color isKindOfClass:[NSString class]])
        return [[QColorPickerElement colorFromHexString:color] imageByDrawingCircleOfColor];
    return [[UIColor blackColor] imageByDrawingCircleOfColor];
}


- (void)createElements {
    _sections = nil;
    self.presentationMode = QPresentationModeNavigationInPopover;
    _internalRadioItemsSection = [[QSection alloc] init];
    _parentSection = _internalRadioItemsSection;

    [self addSection:_parentSection];

    for (NSUInteger i=0; i< [_items count]; i++){
        QRadioItemElement *element = [[QRadioItemElement alloc] initWithIndex:i RadioElement:self];
        element.image = [self getImageFromItem:[self.items objectAtIndex:i]];
        element.title = [[self.items objectAtIndex:i] objectAtIndex:0];
        [_parentSection addElement:element];
    }
}

+ (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

- (void)setSelectedColor:(NSString *)colorName {
    for (NSArray *item in _items){
        if ([colorName isEqualToString:[item objectAtIndex:0]]) {
            self.selected = [_items indexOfObject:item];
            return;
        }
    }
    self.selected = 0;

    [self handleEditingChanged];
}


@end
