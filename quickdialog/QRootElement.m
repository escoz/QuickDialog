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

#import "QElement.h"
#import "QRootElement.h"
#import "QSection.h"
#import "QuickDialogController.h"
#import "QRadioElement.h"

@implementation QRootElement

@synthesize title = _title;
@synthesize sections = _sections;
@synthesize grouped = _grouped;
@synthesize controllerName = _controllerName;


- (void)parseData:(id)inData forElement:(id)inElement {
    if ([inData isKindOfClass:[NSDictionary class]]) {
        [inData enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            if (([obj isKindOfClass:[NSString class]] && ![key isEqualToString:@"qType"]) || [obj isKindOfClass:[NSNumber class]]) {
                [inElement setValue:obj forKey:key];
            }
            else if ([obj isKindOfClass:[NSArray class]]) {
                if ([inData objectForKey:@"qType"]) {
                    NSString* type = [inData objectForKey:@"qType"];
                    
                    if ([type isEqualToString:@"QRootElement"]) {
                        QSection* newSection = [[QSection alloc] initWithTitle:key];
                        
                        [self parseData:obj forElement:newSection];
                        
                        [inElement addSection:newSection];
                    }
                    else if ([type isEqualToString:@"QRadioElement"]) {
                        NSMutableArray* newArray = [NSMutableArray new];
                        
                        [obj enumerateObjectsUsingBlock:^(id obj2, NSUInteger idx, BOOL *stop) {
                            [self parseData:obj2 forElement:newArray];
                        }];
                        
                        [inElement setItems:newArray];
                    }
                }
            }
        }];
    }
    else if ([inData isKindOfClass:[NSArray class]]) {
        [inData enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([obj isKindOfClass:[NSDictionary class]] && [obj objectForKey:@"qType"]) {
                id newElement = [[NSClassFromString([obj objectForKey:@"qType"]) alloc] init];
                
                [self parseData:obj forElement:newElement];
                
                [inElement addElement:newElement];
            }
        }];
    }
    else if ([inData isKindOfClass:[NSString class]]) {
        [inElement addObject:inData];
    }
}

- (QElement*)initWithContentsOfFile:(NSString*)inFile {
    NSDictionary* initData = [NSDictionary dictionaryWithContentsOfFile:inFile];
    QRootElement* retElement = [[QRootElement alloc] init];
    
    [self parseData:initData forElement:retElement];
    
    return retElement;
}
- (QElement*)initWithPlist:(NSString*)inPlist {
    NSArray* fileComponents = [inPlist componentsSeparatedByString:@"."];
    
    if ([fileComponents count] == 2) {
        return [self initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[fileComponents objectAtIndex:0] ofType:[fileComponents objectAtIndex:1]]];
    }
    
    return nil;
}
- (void)addSection:(QSection *)section {
    if (_sections==nil)
        _sections = [[NSMutableArray alloc] init];

    [_sections addObject:section];
    section.rootElement = self;
}

- (QSection *)getSectionForIndex:(NSInteger)index {
   return [_sections objectAtIndex:(NSUInteger) index];
}

- (NSInteger)numberOfSections {
    return [_sections count];
}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {
    UITableViewCell *cell = [super getCellForTableView:tableView controller:controller];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    cell.textLabel.text = _title;
    return cell;
}

- (void)selected:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller indexPath:(NSIndexPath *)path {
    [super selected:tableView controller:controller indexPath:path];

    if (self.sections==nil)
            return;

    [controller displayViewControllerForRoot:self];
}

- (void)fetchValueIntoObject:(id)obj {
    for (QSection *s in _sections){
        for (QElement *el in s.elements) {
            [el fetchValueIntoObject:obj];
        }
    }
}


@end