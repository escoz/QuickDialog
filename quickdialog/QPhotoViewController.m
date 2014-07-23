//
//  QPhotoViewController.m
//  QuickDialog
//
//  Created by Francis Visoiu Mistrih on 18/07/2014.
//
//

#import "QPhotoViewController.h"

const NSString *kPhoto = @"Photo";
const NSString *kActions = @"Actions";
const NSString *kDelete = @"Supprimer";
const NSString *kInformations = @"Informations";
const NSString *kCode = @"Code";
const NSString *kBrand = @"Marque";
const NSString *kProduct = @"Produit";
const NSString *kTimeZoneFormat = @"+0000";
const NSUInteger kImageHeight = 300;

@interface QPhotoViewController ()

@end

@implementation QPhotoViewController

- (QPhotoViewController *)initWithPhoto:(UIImage *)photo photoData:(NSMutableDictionary *)photoData type:(PhotoSource)type {
    QRootElement *root = [QPhotoViewController buildWithPhoto:photo photoData:photoData type:type];
    self = [super initWithRoot:root];
    if (self) {
        _photoData = photoData;
    }

    return self;
}

+ (QRootElement *)buildWithPhoto:(UIImage *)photo photoData:(NSMutableDictionary *)photoData type:(PhotoSource)type {
    QRootElement *root = [[QRootElement alloc] init];
    root.presentationMode = QPresentationModeModalFullScreen;
    root.controllerName = @"QPhotoViewController";
    root.grouped = YES;

    QSection *photoSection = [[QSection alloc] initWithTitle:[NSString stringWithFormat:@"%@",kPhoto]];
    QPhotoElement *photoElement = [[QPhotoElement alloc] initWithImage:photo];
    photoElement.height = kImageHeight;
    [photoElement setEnabled:type != PhotoSourceWeb]; //disable selection if the photo comes from web
    [photoSection addElement:photoElement];
    [root addSection:photoSection];

    QSection *actionsSection = [[QSection alloc] initWithTitle:[NSString stringWithFormat:@"%@",kActions]];
    QButtonElement *delete = [[QButtonElement alloc] initWithTitle:[NSString stringWithFormat:@"%@",kDelete]];
    delete.appearance = [root.appearance copy];
    [delete.appearance setBackgroundColorEnabled:[UIColor redColor]];
    delete.controllerAction = @"deletePhoto:";
    [actionsSection addElement:delete];
    [root addSection:actionsSection];

    QDynamicDataSection *dataSection = [[QDynamicDataSection alloc] initWithTitle:[NSString stringWithFormat:@"%@",kInformations]];
    [dataSection setKey:@"dataSection"];
    dataSection.bind = @"iterate:el";
    dataSection.elementTemplate = @{@"type":@"QLabelElement", @"bind":@"title:name, value:value"};
    NSMutableArray *data = [NSMutableArray array];

    [self iteratePhotoData:photoData andDataArray:data];

    if (data.count > 0) {
        [dataSection bindToObject:@{@"el":data}];
        [root addSection:dataSection];
    }

    return root;
}

+ (void)iteratePhotoData:(NSDictionary *)photoData andDataArray:(NSMutableArray *)data {
    for (NSString *key in [photoData allKeys]) {
        //checking if photoData[key] is a ditionary itself
        if ([photoData[key] respondsToSelector:@selector(allKeys)]) {
            [QPhotoViewController iteratePhotoData:photoData[key] andDataArray:data];
        } else {
            [data addObject:@{@"name":[NSString stringWithFormat:@"%@",[key capitalizedString]],@"value":photoData[key]}];
        }
    }
}

- (void)deletePhoto:(id)sender {
    [_photoData removeAllObjects];
    [_element.appearance setBackgroundColorEnabled:[UIColor whiteColor]];
    //ugly way to get the tableview. TO FIX
    [[(QuickDialogController *)_element.controller quickDialogTableView] reloadCellForElements:_element, nil];
    [self popToPreviousRootElement];
    self.element.image = nil; //force ARC to free
}


@end
