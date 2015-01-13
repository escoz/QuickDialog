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
        if ([QRootBuilderStringToTypeConversionDict objectForKey:propertyName]!=nil) {
            [target setValue:[[QRootBuilderStringToTypeConversionDict objectForKey:propertyName] objectForKey:value] forKeyPath:propertyName];
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
                        [itemsTranslated replaceObjectAtIndex:i withObject:QTranslate(obj)];
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
    QRootBuilderStringToTypeConversionDict = [[NSDictionary alloc] initWithObjectsAndKeys:

                    [[NSDictionary alloc] initWithObjectsAndKeys:
                                [NSNumber numberWithInt:QPresentationModeNormal], @"Normal",
                                [NSNumber numberWithInt:QPresentationModeNavigationInPopover], @"NavigationInPopover",
                                [NSNumber numberWithInt:QPresentationModeModalForm], @"ModalForm",
                                [NSNumber numberWithInt:QPresentationModePopover], @"Popover",
                               [NSNumber numberWithInt:QPresentationModeModalFullScreen], @"ModalFullScreen",
                               [NSNumber numberWithInt:QPresentationModeModalPage], @"ModalPage",
                                nil], @"presentationMode",


                    [[NSDictionary alloc] initWithObjectsAndKeys:
                        [NSNumber numberWithInt:UITextAutocapitalizationTypeNone], @"None",
                                [NSNumber numberWithInt:UITextAutocapitalizationTypeWords], @"Words",
                                [NSNumber numberWithInt:UITextAutocapitalizationTypeSentences], @"Sentences",
                                [NSNumber numberWithInt:UITextAutocapitalizationTypeAllCharacters], @"AllCharacters",
                                nil], @"autocapitalizationType",

                    [[NSDictionary alloc] initWithObjectsAndKeys:
                            [NSNumber numberWithInt:UITextAutocorrectionTypeDefault], @"Default",
                                    [NSNumber numberWithInt:UITextAutocorrectionTypeNo], @"No",
                                    [NSNumber numberWithInt:UITextAutocorrectionTypeYes], @"Yes",
                                    nil], @"autocorrectionType",

                    [[NSDictionary alloc] initWithObjectsAndKeys:
                                                [NSNumber numberWithInt:UITableViewCellStyleDefault], @"Default",
                                                        [NSNumber numberWithInt:UITableViewCellStyleSubtitle], @"Subtitle",
                                                        [NSNumber numberWithInt:UITableViewCellStyleValue2], @"Value2",
                                                        [NSNumber numberWithInt:UITableViewCellStyleValue1], @"Value1",
                                                        nil], @"cellStyle",

                    [[NSDictionary alloc] initWithObjectsAndKeys:
                                    [NSNumber numberWithInt:UIKeyboardTypeDefault], @"Default",
                                    [NSNumber numberWithInt:UIKeyboardTypeASCIICapable], @"ASCIICapable",
                                    [NSNumber numberWithInt:UIKeyboardTypeNumbersAndPunctuation], @"NumbersAndPunctuation",
                                    [NSNumber numberWithInt:UIKeyboardTypeURL], @"URL",
                                    [NSNumber numberWithInt:UIKeyboardTypeNumberPad], @"NumberPad",
                                    [NSNumber numberWithInt:UIKeyboardTypePhonePad], @"PhonePad",
                                    [NSNumber numberWithInt:UIKeyboardTypeNamePhonePad], @"NamePhonePad",
                                    [NSNumber numberWithInt:UIKeyboardTypeEmailAddress], @"EmailAddress",
                                    [NSNumber numberWithInt:UIKeyboardTypeDecimalPad], @"DecimalPad",
                                    [NSNumber numberWithInt:UIKeyboardTypeTwitter], @"Twitter",
                                    [NSNumber numberWithInt:UIKeyboardTypeAlphabet], @"Alphabet",
                                    nil], @"keyboardType",

                    [[NSDictionary alloc] initWithObjectsAndKeys:
                            [NSNumber numberWithInt:UIKeyboardAppearanceDefault], @"Default",
                                    [NSNumber numberWithInt:UIKeyboardAppearanceAlert], @"Alert",
                                    nil], @"keyboardAppearance",

                    [[NSDictionary alloc] initWithObjectsAndKeys:
                                    [NSNumber numberWithInt:UIActivityIndicatorViewStyleGray], @"Gray",
                                    [NSNumber numberWithInt:UIActivityIndicatorViewStyleWhite], @"White",
                                    [NSNumber numberWithInt:UIActivityIndicatorViewStyleWhiteLarge], @"WhiteLarge",
                                    nil], @"indicatorViewStyle",

                    [[NSDictionary alloc] initWithObjectsAndKeys:
                                                        [NSNumber numberWithInt:UITableViewCellAccessoryDetailDisclosureButton], @"DetailDisclosureButton",
                                                        [NSNumber numberWithInt:UITableViewCellAccessoryCheckmark], @"Checkmark",
                                                        [NSNumber numberWithInt:UITableViewCellAccessoryDisclosureIndicator], @"DisclosureIndicator",
                                                        [NSNumber numberWithInt:UITableViewCellAccessoryNone], @"None",
                                                        nil], @"accessoryType",

                    [[NSDictionary alloc] initWithObjectsAndKeys:
                                    [NSNumber numberWithInt:UIDatePickerModeDate], @"Date",
                                    [NSNumber numberWithInt:UIDatePickerModeTime], @"Time",
                                    [NSNumber numberWithInt:UIDatePickerModeDateAndTime], @"DateAndTime",
                                    nil], @"mode",

                    [[NSDictionary alloc] initWithObjectsAndKeys:
                                    [NSNumber numberWithInt:UIReturnKeyDefault], @"Default",
                                    [NSNumber numberWithInt:UIReturnKeyGo], @"Go",
                                    [NSNumber numberWithInt:UIReturnKeyGoogle], @"Google",
                                    [NSNumber numberWithInt:UIReturnKeyJoin], @"Join",
                                    [NSNumber numberWithInt:UIReturnKeyNext], @"Next",
                                    [NSNumber numberWithInt:UIReturnKeyRoute], @"Route",
                                    [NSNumber numberWithInt:UIReturnKeySearch], @"Search",
                                    [NSNumber numberWithInt:UIReturnKeySend], @"Send",
                                    [NSNumber numberWithInt:UIReturnKeyYahoo], @"Yahoo",
                                    [NSNumber numberWithInt:UIReturnKeyDone], @"Done",
                                    [NSNumber numberWithInt:UIReturnKeyEmergencyCall], @"EmergencyCall",
                                    nil], @"returnKeyType",

                    [[NSDictionary alloc] initWithObjectsAndKeys:
                                                        [NSNumber numberWithInt:QLabelingPolicyTrimTitle], @"trimTitle",
                                                        [NSNumber numberWithInt:QLabelingPolicyTrimValue], @"trimValue",
                                    nil], @"labelingPolicy",


                    [[NSDictionary alloc] initWithObjectsAndKeys:
                                                            [NSNumber numberWithInt:UIImagePickerControllerSourceTypePhotoLibrary], @"photoLibrary",
                                                            [NSNumber numberWithInt:UIImagePickerControllerSourceTypeCamera], @"camera",
                                                            [NSNumber numberWithInt:UIImagePickerControllerSourceTypeSavedPhotosAlbum], @"savedPhotosAlbum",
                                    nil], @"source",

                    [[NSDictionary alloc] initWithObjectsAndKeys:
                            [NSNumber numberWithInt:QLabelingPolicyTrimTitle], @"trimTitle",
                            [NSNumber numberWithInt:QLabelingPolicyTrimValue], @"trimValue",
                            nil], @"labelingPolicy",

            nil];

}


@end
