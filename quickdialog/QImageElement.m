//
// Copyright 2012 Ludovic Landry - http://about.me/ludoviclandry
//
// Licensed under the Apache License, Version 2.0 (the "License"); you may not use this
// file except in compliance with the License. You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software distributed under
// the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF
// ANY KIND, either express or implied. See the License for the specific language governing
// permissions and limitations under the License.
//

#import "QImageTableViewCell.h"

@interface QImageElement () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPopoverControllerDelegate>

@property(nonatomic, retain) UIImagePickerController *imagePickerController;
@property(nonatomic, strong) UIPopoverController *popoverController;

@end

@implementation QImageElement {
    enum UIImagePickerControllerSourceType _source;
}

@synthesize imageValue;
@synthesize imageMaxLength;
@synthesize imagePickerController;
@synthesize popoverController;
@synthesize source = _source;


- (QEntryElement *)init {
    self = [super init];
    if (self) {
        _source = UIImagePickerControllerSourceTypePhotoLibrary;
        self.imageMaxLength = FLT_MAX;
    }

    return self;
}

- (QImageElement *)initWithTitle:(NSString *)aTitle detailImage:(UIImage *)anImage {
    self = [super init];
    if (self) {
        self.title = aTitle;
        self.imageValue = anImage;
        self.imageMaxLength = FLT_MAX;
        _source = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    return self;
}

- (void)setImageValueNamed:(NSString *)name {
    self.imageValue = [UIImage imageNamed:name];
    [self reducedImageIfNeeded];
}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {
    QImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuickformImageElement"];
    if (cell == nil) {
        cell = [[QImageTableViewCell alloc] init];
    }
    [cell prepareForElement:self inTableView:tableView];

    return cell;
}

- (void)selected:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller indexPath:(NSIndexPath *)path {
    [tableView deselectRowAtIndexPath:path animated:YES];

    [self presentImagePicker:tableView controller:controller path:path];
}

- (void)fetchValueIntoObject:(id)obj
{
	if (_key == nil) {
		return;
	}
	[obj setValue:self.imageValue forKey:_key];
}

- (void)presentImagePicker:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller path:(NSIndexPath *)path {
    if ([UIImagePickerController isSourceTypeAvailable:_source]) {
        self.imagePickerController.sourceType = _source;
    } else {
        NSLog(@"Source not available, using default Library type.");
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }

    BOOL isPhone = [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone;
    if (isPhone) {
        [controller displayViewController:self.imagePickerController];
    } else {
        UITableViewCell *tableViewCell = [tableView cellForRowAtIndexPath:path];
        if ([tableViewCell isKindOfClass:[QImageTableViewCell class]]) {
            UIView *presentingView = ((QImageTableViewCell *) tableViewCell).imageViewButton;

            UIPopoverController *aPopoverController = [[UIPopoverController alloc] initWithContentViewController:self.imagePickerController];
            [aPopoverController presentPopoverFromRect:presentingView.bounds
                                                inView:presentingView
                              permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
            aPopoverController.delegate = self;
            self.popoverController = aPopoverController;
        }
    }
}

- (UIImagePickerController *)imagePickerController {
    if (!imagePickerController) {
        imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
    }
    return imagePickerController;
}

- (void)dismissImagePickerController {
    BOOL isPhone = [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone;
    if (isPhone) {
        [self.imagePickerController dismissViewControllerAnimated:YES completion:NULL];
    } else {
        [self.popoverController dismissPopoverAnimated:YES];
    }
}

- (void)reducedImageIfNeeded {
    if (self.imageValue.size.width > self.imageMaxLength || self.imageValue.size.height > self.imageMaxLength) {
        float scale = self.imageMaxLength / MAX(self.imageValue.size.width, self.imageValue.size.height);
        CGSize scaledSize = CGSizeMake(self.imageValue.size.width * scale, self.imageValue.size.height * scale);

        UIGraphicsBeginImageContext(scaledSize);
        [self.imageValue drawInRect:CGRectMake(0, 0, scaledSize.width, scaledSize.height)];
        self.imageValue = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
}

#pragma mark -
#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {

    self.imageValue = [info valueForKey:UIImagePickerControllerOriginalImage];
    [self reducedImageIfNeeded];

    [self dismissImagePickerController];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissImagePickerController];
}

#pragma mark -
#pragma mark UIPopoverControllerDelegate

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    self.popoverController = nil;
}

@end
