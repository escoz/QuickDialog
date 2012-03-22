//
//  QPhotoElement.m
//  TacosTaco
//
//  Created by Rodolfo Wilhelmy on 1/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "QPhotoElement.h"
#import <QuartzCore/QuartzCore.h>

#define kPhotoViewTag 9000

@implementation QPhotoElement

@synthesize photo;
@synthesize photoSize;
@synthesize photoView;

- (QPhotoElement *)initWithTitle:(NSString *)title photo:(UIImage *)aPhoto
{
    self = [self initWithTitle:title Value:nil];
    
    if (self) {
        photo = aPhoto;        
    }
    
    return self;
}

- (void)updatePhoto:(UIImage *)aPhoto
{
    photo = aPhoto;
    photoView.image = photo;
}

#pragma QElement overwrite

- (CGFloat)getRowHeightForTableView:(QuickDialogTableView *)tableView {
    return photoSize.height? photoSize.height + 10.0 : 44.0;
}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller 
{
    UITableViewCell *cell = [super getCellForTableView:tableView controller:controller];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    if (self.photo != nil) {
        CGFloat cellWidth = cell.frame.size.width;
        CGFloat cellHeight = [self getRowHeightForTableView:tableView];
        CGFloat padding = 30.0;
        CGFloat photoWidth = photoSize.width? photoSize.width : 40.0;
        CGFloat photoHeight = photoSize.height? photoSize.height : 40.0;
        CGRect photoFrame = CGRectMake(cellWidth - photoWidth - padding, cellHeight / 2.0 - photoHeight / 2.0, photoWidth, photoHeight);
        
        UIImageView *photoImageView = [[UIImageView alloc] initWithFrame:photoFrame];
        self.photoView = photoImageView;
        self.photoView.image = self.photo;
        self.photoView.tag = kPhotoViewTag;
        self.photoView.layer.cornerRadius = 4.0;
        self.photoView.layer.masksToBounds = YES;
        [cell.contentView addSubview:self.photoView];
    }
    
    return cell;
}

- (void)selected:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller indexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self handleElementSelected:controller];
}

@end
