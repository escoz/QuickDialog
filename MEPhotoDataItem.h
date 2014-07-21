//
//  MEPhotoDataItem.h
//  QuickDialog
//
//  Created by Francis Visoiu Mistrih on 21/07/2014.
//
//

#import <Foundation/Foundation.h>

@interface MEPhotoDataItem : NSObject

//general
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) NSMutableDictionary *metadata;
@property BOOL isPhotoTaken;

//barcode scanner
@property (strong,nonatomic) NSString *code;
@property (strong,nonatomic) NSString *productBrand;
@property (strong,nonatomic) NSString *productName;

//UI
@property (strong, nonatomic) NSString *previewTitle;
@property (strong, nonatomic) NSString *takeTitle;

@end
