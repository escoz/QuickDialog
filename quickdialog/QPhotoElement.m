//
//  QPhotoElement.m
//  QuickDialog
//
//  Created by Francis Visoiu Mistrih on 16/07/2014.
//
//

#import "QPhotoElement.h"
#define green_color [UIColor colorWithRed:0.373 green:0.878 blue:0.471 alpha:1]

@implementation QPhotoElement

- (QPhotoElement *)init
{
    self = [super init];
    if (self) {
        _isPhotoTaken = false;
    }
    return self;
}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {
    QTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuickformPhotoElement"];
    if (cell == nil){
        cell = [[QTableViewCell alloc] init];
    }
    [cell applyAppearanceForElement:self];

    //[cell.imageView setImage:_image ? _image : [UIImage imageNamed:@"icon"]];
    cell.textLabel.text = _isPhotoTaken ? @"Voir photo" : @"Prendre photo";
    return cell;
}

- (void)selected:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller indexPath:(NSIndexPath *)indexPath {
    if (_isPhotoTaken) {
        //show the photo to the user
        UIViewController *vc = [[UIViewController alloc] init];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:controller.view.frame];
        [imageView setContentMode:UIViewContentModeScaleAspectFit];
        [imageView setImage:_image];
        [vc.view addSubview:imageView];
        [controller.navigationController pushViewController:vc animated:YES];
    } else {
        //take a new picture
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
#warning to change to self.controller
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.allowsEditing = NO;
        [controller presentViewController:picker animated:YES completion:nil];
    }

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    _image = [info objectForKey:UIImagePickerControllerOriginalImage];

    _isPhotoTaken = YES;
    [picker dismissViewControllerAnimated:YES completion:^{
        [[(QuickDialogController *)self.controller quickDialogTableView] reloadCellForElements:self, nil];
    }];
}

@end
