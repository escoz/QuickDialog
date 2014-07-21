//
//  QPhotoViewController.m
//  QuickDialog
//
//  Created by Francis Visoiu Mistrih on 18/07/2014.
//
//

#import "QPhotoViewController.h"

#import "MEPhotoDataItem.h"

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

- (void)deletePhoto:(id)sender {
    _photoData.isPhotoTaken = NO;
    [_element.appearance setBackgroundColorEnabled:[UIColor whiteColor]];
    //ugly way to get the tableview. TO FIX
    [[(QuickDialogController *)self.navigationController.viewControllers[0] quickDialogTableView] reloadCellForElements:_element, nil];
    [self popToPreviousRootElement];
    _photoData.image = nil; //force ARC to free
    _photoData.metadata = nil; //force ARC to free

}
+ (QRootElement *)buildWithPhotoData:(MEPhotoDataItem *)photoData type:(PhotoSource)type {
    QRootElement *root = [[QRootElement alloc] init];
    root.presentationMode = QPresentationModeModalFullScreen;
    root.controllerName = @"QPhotoViewController";
    root.grouped = YES;

    QSection *photoSection = [[QSection alloc] initWithTitle:[NSString stringWithFormat:@"%@",kPhoto]];
    QPhotoElement *photo = [[QPhotoElement alloc] initWithImage:photoData.image];
    photo.height = kImageHeight;
    [photo setEnabled:type != PhotoSourceWeb]; //disable selection if the photo comes from web
    [photoSection addElement:photo];
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

    if (photoData.metadata[@"{TIFF}"][@"DateTime"])
        [data addObject:@{@"name":@"Date",@"value":[photoData.metadata[@"{TIFF}"][@"DateTime"] stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@",kTimeZoneFormat] withString:@""]}];

    if (photoData.metadata[@"{TIFF}"][@"Model"])
        [data addObject:@{@"name":@"Model",@"value":photoData.metadata[@"{TIFF}"][@"Model"]}];

    if (photoData.metadata[@"{TIFF}"][@"Software"])
        [data addObject:@{@"name":@"Model",@"value":photoData.metadata[@"{TIFF}"][@"Software"]}];

    if (photoData.code)
        [data addObject:@{@"name":[NSString stringWithFormat:@"%@",kCode], @"value":photoData.code}];

    if (photoData.code)
        [data addObject:@{@"name":[NSString stringWithFormat:@"%@",kBrand], @"value":photoData.productBrand}];

    if (photoData.code)
        [data addObject:@{@"name":[NSString stringWithFormat:@"%@",kProduct], @"value":photoData.productName}];

    if (data.count > 0) {
        [dataSection bindToObject:@{@"el":data}];
        [root addSection:dataSection];
    }

    return root;
}

- (QPhotoViewController *)initWithPhotoData:(MEPhotoDataItem *)photoData type:(PhotoSource)type {
    QRootElement *root = [QPhotoViewController buildWithPhotoData:photoData type:type];
    self = [super initWithRoot:root];
    if (self) {
        _photoData = photoData;
    }

    return self;
}

@end
