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

+ (QRootElement *)buildWithImage:(UIImage *)image andType:(PhotoSource)type {
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

/*    QSection *section = [[QSection alloc] initWithTitle:@"Information"];
    [section addElement:[[QTextElement alloc] initWithText:@"Here's some more info about this app."]];
    [details addSection:section];
*/
    return root;
}

- (QPhotoViewController *)initWithPhoto:(UIImage *)image andType:(PhotoSource)type {
    QRootElement *root = [QPhotoViewController buildWithImage:image andType:type];
    self = [super initWithRoot:root];
    if (self) {
        
    }

    return self;
}

@end
