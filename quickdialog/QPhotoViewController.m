//
//  QPhotoViewController.m
//  QuickDialog
//
//  Created by Francis Visoiu Mistrih on 18/07/2014.
//
//

#import "QPhotoViewController.h"

@interface QPhotoViewController ()

@end

@implementation QPhotoViewController

+ (QRootElement *)buildWithImage:(UIImage *)image metadata:(NSDictionary *)metadata type:(PhotoSource)type {
    QRootElement *root = [[QRootElement alloc] init];
    root.presentationMode = QPresentationModeModalFullScreen;
    root.controllerName = @"QPhotoViewController";
    root.grouped = YES;

    QSection *photoSection = [[QSection alloc] initWithTitle:@"Photo"];
    QPhotoElement *photo = [[QPhotoElement alloc] initWithImage:image];
    photo.height = 300;
    [photo setEnabled:type != PhotoSourceWeb]; //disable selection if the photo comes from web
    [photoSection addElement:photo];
    [root addSection:photoSection];

    QDynamicDataSection *dataSection = [[QDynamicDataSection alloc] initWithTitle:@"Informations"];
    [dataSection setKey:@"dataSection"];
    dataSection.bind = @"iterate:el";
    dataSection.elementTemplate = @{@"type":@"QLabelElement", @"bind":@"title:name, value:value"};
    [dataSection bindToObject:@{@"el":@[@{@"name":@"Date",@"value":metadata[@"{TIFF}"][@"DateTime"]},
                                        @{@"name":@"Model",@"value":metadata[@"{TIFF}"][@"Model"]},
                                        @{@"name":@"Version",@"value":metadata[@"{TIFF}"][@"Software"]},
                                        ]}];

    [root addSection:dataSection];


/*    QSection *section = [[QSection alloc] initWithTitle:@"Information"];
    [section addElement:[[QTextElement alloc] initWithText:@"Here's some more info about this app."]];
    [details addSection:section];
*/
    return root;
}

- (QPhotoViewController *)initWithPhoto:(UIImage *)image metadata:(NSDictionary *)metadata type:(PhotoSource)type {
    QRootElement *root = [QPhotoViewController buildWithImage:image metadata:metadata type:type];
    self = [super initWithRoot:root];
    if (self) {
        //do something
    }

    return self;
}

@end
