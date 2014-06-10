//
// Copyright 2011 ESCOZ Inc  - http://escoz.com
//
// Licensed under the Apache License, Version 2.0 (the "License"); you may not use this
// file except in compliance with the License. You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software distributed under
// the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF
// ANY KIND, either express or implied. See the License for the specific language governing
// permissions and limitations under the License.
//


#import "QRootBuilder.h"

NSDictionary *QRootBuilderStringToTypeConversionDict;

@interface QRootBuilder ()
- (void)buildSectionWithObject:(id)obj forRoot:(QRootElement *)root;

- (void)initializeMappings;

@end

@implementation QRootBuilder

+ (void)trySetProperty:(NSString *)propertyName onObject:(id)target withValue:(id)value  localized:(BOOL)shouldLocalize{
    shouldLocalize = shouldLocalize && ![propertyName isEqualToString:@"bind"] && ![propertyName isEqualToString:@"type"];
    if ([value isKindOfClass:[NSString class]]) {
        if (QRootBuilderStringToTypeConversionDict[propertyName] !=nil) {
            [target setValue:[QRootBuilderStringToTypeConversionDict[propertyName] objectForKey:value] forKeyPath:propertyName];
        } else {
            [target setValue:shouldLocalize ? QTranslate(value) : value forKeyPath:propertyName];
        }
    } else if ([value isKindOfClass:[NSNumber class]]){
        [target setValue:value forKeyPath:propertyName];
    } else if ([value isKindOfClass:[NSArray class]]) {

        NSUInteger i= 0;
        NSMutableArray * itemsTranslated = [(NSArray *) value mutableCopy];

        if (shouldLocalize){
            for (id obj in (NSArray *)value){
                if ([obj isKindOfClass:[NSString class]]){
                    @try {
                        itemsTranslated[i] = QTranslate(obj);
                    }
                    @catch (NSException * e) {
                        NSLog(@"Exception: %@", e);
                    }
                }
                i++;
            }
        }

        [target setValue:itemsTranslated forKeyPath:propertyName];
    } else if ([value isKindOfClass:[NSDictionary class]]){
        [target setValue:value forKeyPath:propertyName];
    } else if (value == [NSNull null]) {
        [target setValue:nil forKeyPath:propertyName];
    } else if ([value isKindOfClass:[NSObject class]]){
        [target setValue:value forKeyPath:propertyName];
    } else if (value == nil){
        [target setValue:nil forKeyPath:propertyName];
    }
}

- (void)updateObject:(id)element withPropertiesFrom:(NSDictionary *)dict {
    for (NSString *key in dict.allKeys){
        if ([key isEqualToString:@"type"] || [key isEqualToString:@"sections"]|| [key isEqualToString:@"elements"])
            continue;

        id value = [dict valueForKey:key];
        [QRootBuilder trySetProperty:key onObject:element withValue:value localized:YES];
    }
}

- (QElement *)buildElementWithObject:(id)obj {
    QElement *element = [[NSClassFromString([obj valueForKey:[NSString stringWithFormat:@"type"]]) alloc] init];
    if (element==nil) {
        NSLog(@"Couldn't build element for type %@", [obj valueForKey:[NSString stringWithFormat:@"type"]]);
        return nil;
    }
    [self updateObject:element withPropertiesFrom:obj];
    
    if ([element isKindOfClass:[QRootElement class]] && [obj valueForKey:[NSString stringWithFormat:@"sections"]]!=nil) {
        for (id section in (NSArray *)[obj valueForKey:[NSString stringWithFormat:@"sections"]]){
            [self buildSectionWithObject:section forRoot:(QRootElement *) element];
        }
    }
    return element;
}

- (QSection *)buildSectionWithObject:(NSDictionary *)obj {
    QSection *sect = nil;
    if ([obj valueForKey:[NSString stringWithFormat:@"type"]]!=nil){
        sect = [[NSClassFromString([obj valueForKey:[NSString stringWithFormat:@"type"]]) alloc] init];
    } else {
        sect = [[QSection alloc] init];
    }
    [self updateObject:sect withPropertiesFrom:obj];
    return sect;
}

- (void)buildSectionWithObject:(id)obj forRoot:(QRootElement *)root {
    QSection *sect = nil;
    if ([obj valueForKey:[NSString stringWithFormat:@"type"]]!=nil){
        sect = [[NSClassFromString([obj valueForKey:[NSString stringWithFormat:@"type"]]) alloc] init];
    } else {
        sect = [[QSection alloc] init];
    }
    [self updateObject:sect withPropertiesFrom:obj];
    [root addSection:sect];
    for (id element in (NSArray *)[obj valueForKey:[NSString stringWithFormat:@"elements"]]){
        QElement *elementNode = [self buildElementWithObject:element];
        if (elementNode) {
            [sect addElement:elementNode];
        }
    }
}

- (QRootElement *)buildWithObject:(id)obj {
    if (QRootBuilderStringToTypeConversionDict ==nil)
        [self initializeMappings];
    
    QRootElement *root = [QRootElement new];
    [self updateObject:root withPropertiesFrom:obj];
    for (id section in (NSArray *)[obj valueForKey:[NSString stringWithFormat:@"sections"]]){
        [self buildSectionWithObject:section forRoot:root];
    }
    
    return root;
}

- (void)initializeMappings {
    QRootBuilderStringToTypeConversionDict = @{
            @"presentationMode" : @{
                    @"Normal" : @(QPresentationModeNormal), 
                    @"NavigationInPopover" : @(QPresentationModeNavigationInPopover), 
                    @"ModalForm" : @(QPresentationModeModalForm), 
                    @"Popover" : @(QPresentationModePopover), 
                    @"ModalFullScreen" : @(QPresentationModeModalFullScreen), 
                    @"ModalPage" : @(QPresentationModeModalPage)
            }, 
            @"autocapitalizationType" : @{
                    @"None" : @(UITextAutocapitalizationTypeNone), 
                    @"Words" : @(UITextAutocapitalizationTypeWords), 
                    @"Sentences" : @(UITextAutocapitalizationTypeSentences), 
                    @"AllCharacters" : @(UITextAutocapitalizationTypeAllCharacters)
            }, 
            @"autocorrectionType" : @{
                    @"Default" : @(UITextAutocorrectionTypeDefault),
                    @"No" : @(UITextAutocorrectionTypeNo),
                    @"Yes" : @(UITextAutocorrectionTypeYes)},

            @"cellStyle" : @{
                    @"Default" : @(UITableViewCellStyleDefault),
                    @"Subtitle" : @(UITableViewCellStyleSubtitle),
                    @"Value2" :  @(UITableViewCellStyleValue2),
                    @"Value1" : @(UITableViewCellStyleValue1)},

            @"keyboardType" : @{
                    @"Default" : @(UIKeyboardTypeDefault),
                    @"ASCIICapable" : @(UIKeyboardTypeASCIICapable),
                    @"NumbersAndPunctuation" : @(UIKeyboardTypeNumbersAndPunctuation),
                    @"URL" : @(UIKeyboardTypeURL),
                    @"NumberPad" : @(UIKeyboardTypeNumberPad),
                    @"PhonePad" : @(UIKeyboardTypePhonePad),
                    @"NamePhonePad" : @(UIKeyboardTypeNamePhonePad),
                    @"EmailAddress" : @(UIKeyboardTypeEmailAddress),
                    @"DecimalPad" : @(UIKeyboardTypeDecimalPad),
                    @"Twitter" : @(UIKeyboardTypeTwitter),
                    @"Alphabet" : @(UIKeyboardTypeAlphabet)},
            @"keyboardAppearance" :@{
                    @"Default" : @(UIKeyboardAppearanceDefault),
                    @"Alert" : @(UIKeyboardAppearanceAlert)},

            @"indicatorViewStyle" :@{
                    @"Gray" : @(UIActivityIndicatorViewStyleGray),
                    @"White" : @(UIActivityIndicatorViewStyleWhite),
                    @"WhiteLarge" : @(UIActivityIndicatorViewStyleWhiteLarge)},

            @"accessoryType" : @{
                    @"DetailDisclosureButton" : @(UITableViewCellAccessoryDetailDisclosureButton),
                    @"Checkmark" : @(UITableViewCellAccessoryCheckmark),
                    @"DisclosureIndicator" : @(UITableViewCellAccessoryDisclosureIndicator),
                    @"None" : @(UITableViewCellAccessoryNone)},

            @"mode" :  @{
                    @"Date" : @(UIDatePickerModeDate),
                    @"Time" : @(UIDatePickerModeTime),
                    @"DateAndTime" : @(UIDatePickerModeDateAndTime)},

            @"returnKeyType" : @{
                    @"Default" : @(UIReturnKeyDefault),
                    @"Go" : @(UIReturnKeyGo),
                    @"Google" : @(UIReturnKeyGoogle),
                    @"Join" : @(UIReturnKeyJoin),
                    @"Next" : @(UIReturnKeyNext),
                    @"Route" : @(UIReturnKeyRoute),
                    @"Search" : @(UIReturnKeySearch),
                    @"Send" : @(UIReturnKeySend),
                    @"Yahoo" : @(UIReturnKeyYahoo),
                    @"Done" : @(UIReturnKeyDone),
                    @"EmergencyCall" : @(UIReturnKeyEmergencyCall)},

            @"labelingPolicy" : @{
                    @"trimTitle" : @(QLabelingPolicyTrimTitle),
                    @"trimValue" : @(QLabelingPolicyTrimValue)},

            @"source" : @{
                    @"photoLibrary" : @(UIImagePickerControllerSourceTypePhotoLibrary),
                    @"camera" : @(UIImagePickerControllerSourceTypeCamera),
                    @"savedPhotosAlbum" : @(UIImagePickerControllerSourceTypeSavedPhotosAlbum)},

            @"labelingPolicy" : @{
                    @"trimTitle" : @(QLabelingPolicyTrimTitle),
                    @"trimValue" : @(QLabelingPolicyTrimValue)}};

}


@end
