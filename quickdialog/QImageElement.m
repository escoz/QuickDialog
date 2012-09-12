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

@interface QImageElement () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, retain) UIImagePickerController *imagePickerController;
@end

@implementation QImageElement

@synthesize detailImage;
@synthesize detailImageView;
@synthesize imagePickerController;

- (QImageElement *)initWithTitle:(NSString *)aTitle detailImage:(UIImage *)anImage {
   self = [super init];
   if (self) {
      self.title = aTitle;
      self.detailImage = anImage;
   }
   return self;
}

- (void)setDetailImageNamed:(NSString *)name {
   self.detailImage = [UIImage imageNamed:name];
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
   //[super selected:tableView controller:controller indexPath:path];
   //[tableView deselectRowAtIndexPath:path animated:YES];
   
   self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
   [controller displayViewController:self.imagePickerController];
}


- (UIImagePickerController *)imagePickerController {
   if (!imagePickerController) {
      imagePickerController = [[UIImagePickerController alloc] init];
      imagePickerController.delegate = self;
   }
   return imagePickerController;
}

#pragma mark -
#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
   self.detailImage = [info valueForKey:UIImagePickerControllerOriginalImage];
   [self.imagePickerController dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
   [self.imagePickerController dismissViewControllerAnimated:YES completion:NULL];
}

@end
