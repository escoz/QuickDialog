//
//  QPhotoViewController.m
//  QuickDialog
//
//  Created by Francis Visoiu Mistrih on 18/07/2014.
//
//

#import "QPhotoViewController.h"

#import "MEPhotoDataItem.h"

@interface QPhotoViewController ()

@end

@implementation QPhotoViewController

- (void)deletePhoto:(id)sender {
    _photoData.isPhotoTaken = NO;
    //ugly way to get the tableview. TO FIX
    [[(QuickDialogController *)self.navigationController.viewControllers[0] quickDialogTableView] reloadData];
    [self popToPreviousRootElement];
    _photoData.image = nil; //force ARC to free
    _photoData.metadata = nil; //force ARC to free
}

+ (QRootElement *)buildWithPhotoData:(MEPhotoDataItem *)photoData type:(PhotoSource)type {
    QRootElement *root = [[QRootElement alloc] init];
    root.presentationMode = QPresentationModeModalFullScreen;
    root.controllerName = @"QPhotoViewController";
    root.grouped = YES;

    QSection *photoSection = [[QSection alloc] initWithTitle:@"Photo"];

    QButtonElement *delete = [[QButtonElement alloc] initWithTitle:@"Supprimer"];
    delete.appearance = [root.appearance copy];
    [delete.appearance setBackgroundColorEnabled:[UIColor redColor]];
    delete.controllerAction = @"deletePhoto:";
    [photoSection addElement:delete];

    QPhotoElement *photo = [[QPhotoElement alloc] initWithImage:photoData.image];
    photo.height = 300;
    [photo setEnabled:type != PhotoSourceWeb]; //disable selection if the photo comes from web
    [photoSection addElement:photo];
    [root addSection:photoSection];

    QDynamicDataSection *dataSection = [[QDynamicDataSection alloc] initWithTitle:@"Informations"];
    [dataSection setKey:@"dataSection"];
    dataSection.bind = @"iterate:el";
    dataSection.elementTemplate = @{@"type":@"QLabelElement", @"bind":@"title:name, value:value"};
    NSMutableArray *data = [@[@{@"name":@"Date",@"value":[photoData.metadata[@"{TIFF}"][@"DateTime"] stringByReplacingOccurrencesOfString:@"+0000" withString:@""]},
                            @{@"name":@"Model",@"value":photoData.metadata[@"{TIFF}"][@"Model"]},
                            @{@"name":@"Version",@"value":photoData.metadata[@"{TIFF}"][@"Software"]},
                            ] mutableCopy];

    if (photoData.code)
        [data addObject:@{@"name":@"Code", @"value":photoData.code}];

    if (photoData.code)
        [data addObject:@{@"name":@"Marque", @"value":photoData.productBrand}];

    if (photoData.code)
        [data addObject:@{@"name":@"Produit", @"value":photoData.productName}];

    [dataSection bindToObject:@{@"el":data}];
    [root addSection:dataSection];

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
