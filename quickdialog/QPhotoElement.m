//
//  QPhotoElement.m
//  QuickDialog
//
//  Created by Francis Visoiu Mistrih on 18/07/2014.
//
//

#import "QPhotoElement.h"

const float kHeightInit = 150.0; //initial height if not specified
const float kLoadingCellHeight = 50.0;

@interface QPhotoElement () {
    UIActivityIndicatorView *loading; //activity indicator when downloading the image
}

@end

@implementation QPhotoElement

- (QPhotoElement *)init
{
    self = [super init];
    if (self) {
        _height = kHeightInit;
        loading = [[UIActivityIndicatorView alloc] init];
        loading.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        [loading startAnimating];
    }
    return self;
}

- (QPhotoElement *)initWithImage:(UIImage *)image {
    self = [self init];
    if (self) {
        loading = nil;
        _image = image;
        [[(QuickDialogController *)self.controller quickDialogTableView] reloadRowHeights];
    }
    return self;
}

- (QPhotoElement *)initWithURL:(NSString *)url {
    self = [self init];
    if (self) {
        _url = url;
        [self getImageFromURL:url];
    }
    return self;
}

- (void)getImageFromURL:(NSString *)url {
    //URLWithString returns nil if the URL passed is not valid.
    NSURL *imageURL = [NSURL URLWithString:url];
    if (imageURL) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
            dispatch_async(dispatch_get_main_queue(), ^{
                _image = [UIImage imageWithData:imageData];
                if (_image) {
                    loading = nil; //force ARC to release the object
                    [[(QuickDialogController *)self.controller quickDialogTableView] reloadRowHeights];
                    [[(QuickDialogController *)self.controller quickDialogTableView] reloadCellForElements:self, nil];
                } else {
                    //if fails, try again
                    [self getImageFromURL:url];
                }
            });
        });
    }
}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"QuickformPhoto"]];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"QuickformPhoto"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if (!_image) {
        loading.frame = CGRectMake(0, 0, controller.view.frame.size.width, kLoadingCellHeight);
        [cell.contentView addSubview:loading];
        [self getImageFromURL:_url]; //asynchronously download image
    } else {
        UIImageView *mainImage = [[UIImageView alloc] initWithImage:_image];
        mainImage.contentMode = UIViewContentModeScaleAspectFit;
        if (_image.size.width > _image.size.height) {
            _height = _image.size.height * (controller.view.frame.size.width / _image.size.width);
            //reload on main thread. UI has to be on main thread
            dispatch_async(dispatch_get_main_queue(), ^{
                [tableView reloadRowHeights];
            });
        }
        mainImage.frame = CGRectMake(0, 0, controller.view.frame.size.width, _height);
        [cell.contentView addSubview:mainImage];
    }

    return cell;
}

- (CGFloat)getRowHeightForTableView:(QuickDialogTableView *)tableView {
    //if the image height is smaller than the height specified in the JSON (or initial height)
    //choose the smaller one to avoid white space
    if (_image) _height = MIN(_height,_image.size.height);

    //if it's loading, choose the initial height for the loading cell (constant to adapt)
    return loading ? kLoadingCellHeight : _height;
}

@end
