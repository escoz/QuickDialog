//
//  MEPhotoDataItem.m
//  QuickDialog
//
//  Created by Francis Visoiu Mistrih on 21/07/2014.
//
//

#import "MEPhotoDataItem.h"

const NSString *kInitPreviewTitle = @"Voir photo";

@implementation MEPhotoDataItem

- (MEPhotoDataItem *)init
{
    self = [super init];
    if (self) {
        _isPhotoTaken = false;
        _previewTitle = [NSString stringWithFormat:@"%@",kInitPreviewTitle];
    }
    return self;
}

@end
