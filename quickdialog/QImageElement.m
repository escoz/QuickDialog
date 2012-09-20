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

#import "QImageElement.h"

@interface QImageElement () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPopoverControllerDelegate>

@property (nonatomic, retain) UIImagePickerController *imagePickerController;
@property (nonatomic, strong) UIPopoverController *popoverController;

@end

@implementation QImageElement

@synthesize detailImageValue;
@synthesize detailImageMaxLength;
@synthesize imagePickerController;
@synthesize popoverController;

- (QImageElement *)initWithTitle:(NSString *)aTitle detailImage:(UIImage *)anImage {
   self = [super init];
   if (self) {
      self.title = aTitle;
      self.detailImageValue = anImage;
      self.detailImageMaxLength = FLT_MAX;
   }
   return self;
}

- (void)setDetailImageNamed:(NSString *)name {
   self.detailImageValue = [UIImage imageNamed:name];
   [self reducedImageIfNeeded];
}

- (NSString *)detailImageNamed {
   return nil;
}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {
   QImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuickformImageElement"];
   if (cell==nil){
      cell = [[QImageTableViewCell alloc] init];
   }
   [cell prepareForElement:self inTableView:tableView];

   return cell;
}

- (void)selected:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller indexPath:(NSIndexPath *)path {
   [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
   [tableView deselectRowAtIndexPath:path animated:YES];

   self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

   BOOL isPhone = [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone;
   if (isPhone) {
      [controller displayViewController:self.imagePickerController];
   } else {
      UITableViewCell *tableViewCell = [tableView cellForRowAtIndexPath:path];
      if ([tableViewCell isKindOfClass:[QImageTableViewCell class]]) {
         UIView *presentingView = ((QImageTableViewCell *)tableViewCell).detailImageView;

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
   if (self.detailImageValue.size.width > self.detailImageMaxLength || self.detailImageValue.size.height > self.detailImageMaxLength) {
                float scale = self.detailImageMaxLength / MAX(self.detailImageValue.size.width, self.detailImageValue.size.height);
      CGSize scaledSize = CGSizeMake(self.detailImageValue.size.width*scale, self.detailImageValue.size.height*scale);

      UIGraphicsBeginImageContext(scaledSize);
      [self.detailImageValue drawInRect:CGRectMake(0, 0, scaledSize.width, scaledSize.height)];
      self.detailImageValue = UIGraphicsGetImageFromCurrentImageContext();
      UIGraphicsEndImageContext();
        }
}

#pragma mark -
#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {

   self.detailImageValue = [info valueForKey:UIImagePickerControllerOriginalImage];
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
