//
//  QInputPhotoElement.m
//  Mobeye
//
//  Created by Francis Visoiu Mistrih on 24/07/2014.
//  Copyright (c) 2014 MobEye. All rights reserved.
//

#import "QInputPhotoElement.h"

#import "QPhotoViewController.h"

#warning add color to constant
#define green_color [UIColor colorWithRed:0.373 green:0.878 blue:0.471 alpha:1]

NSString *const kPreviewPhoto = @"Voir photo";
NSString *const kPhotoSource = @"Source photo";
NSString *const kCancel = @"Annuler";

@implementation QInputPhotoElement

- (QInputPhotoElement *)init {
    self = [super init];
    if (self) {
        [self initPhotoData];
        self.appearance = [self.appearance copy];
    }

    return self;
}

- (void)initPhotoData {
    self.photoData = [NSMutableDictionary dictionary];
}

- (void)selected:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller indexPath:(NSIndexPath *)indexPath {
    if ([self.photoData[@"isPhotoTaken"] boolValue]) {
        //show the photo to the user
        //create a new image regarding its orientation
        //http://stackoverflow.com/questions/8915630/ios-uiimageview-how-to-handle-uiimage-image-orientation
        UIImage *rotatedImage = [UIImage imageWithCGImage:[self.image CGImage] scale:1.0 orientation:[self.photoData[@"metadata"][@"Orientation"] integerValue]];
        QPhotoViewController *vc = [[QPhotoViewController alloc] initWithPhoto:rotatedImage photoData:self.photoData];
        vc.element = self;
        [controller.navigationController pushViewController:vc animated:YES];
    } else {
        [self presentInputOnController:controller];
    }

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//overriding the method in order to load the image from the assetURL (if present)
- (void)bindToObject:(id)data shallow:(BOOL)shallow {
    [super bindToObject:data shallow:shallow];

    //when no json data comes in, the binding sets photoData to nil.
    //Init it again if that's the case
    if (!self.photoData) {
        [self initPhotoData];
    } else {
        if (self.photoData[@"assetURL"]) {
            ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
            [library assetForURL:[NSURL URLWithString:self.photoData[@"assetURL"]]
                     resultBlock:^(ALAsset *asset) {
                         self.image = [QInputPhotoElement UIImageFromAsset:asset resultBlock:^(UIImage *resultImage) {
                             [self.appearance setBackgroundColorEnabled:green_color];
                         }];
                     }
                    failureBlock:^(NSError *error) {
                        NSLog(@"Error while loading photo: %@",error.description);
                    }];
        }
    }
}

//this is an abstract class
//you have to inherit from this class to use it
//http://stackoverflow.com/questions/1034373/creating-an-abstract-class-in-objective-c
//since Objective-C does not have abstract classes (:/)
//we throw an exception if the user tries to use this method
- (void)presentInputOnController:(UIViewController *)controller {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

+ (UIImage *)UIImageFromAsset:(ALAsset *)asset resultBlock:(void(^)(UIImage *resultImage))resultBlock {
    UIImage *image;
    ALAssetRepresentation *rep = [asset defaultRepresentation];
    CGImageRef iref = [rep fullResolutionImage];
    if (iref) {
        image = [UIImage imageWithCGImage:iref];
        resultBlock(image);
    }

    //return the image if successful
    //return nil if not
    if (!image)
        NSLog(@"Error while transforming ALAsset in UIImage.");

    return image;
}

- (void)setMetadata:(NSDictionary *)metadata assetURL:(NSURL *)assetURL {
    if (metadata) {
        [self.photoData setObject:[assetURL absoluteString] forKey:@"assetURL"];
        [self.photoData setObject:metadata forKey:@"metadata"];
        //set the isPhotoTaken flag here, so pictures without metadata won't be allowed
        [self.photoData setObject:[NSNumber numberWithBool:YES] forKey:@"isPhotoTaken"];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Erreur" message:@"La photo selectionnée n'est pas conforme aux règles Mobeye." delegate:self cancelButtonTitle:[NSString stringWithFormat:@"%@",kCancel] otherButtonTitles:nil];
        [alert show];
    }
}

@end
