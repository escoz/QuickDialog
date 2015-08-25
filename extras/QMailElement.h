//
//  QMailElement.h
//  ConferencesBox
//
//  Created by Richard Huang on 2/16/13.
//  Copyright (c) 2013 ConferencesBox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>
#import "QuickDialog.h"

@interface QMailElement : QLabelElement <MFMailComposeViewControllerDelegate> {

@protected
    NSString *_subject;
    NSString *_messageBody;
    NSArray *_toRecipients;
    NSArray *_ccRecipients;
    NSArray *_bccRecipients;
}

@property(nonatomic, strong) NSString *subject;
@property(nonatomic, strong) NSString *messageBody;
@property(nonatomic, strong) NSArray *toRecipients;
@property(nonatomic, strong) NSArray *ccRecipients;
@property(nonatomic, strong) NSArray *bccRecipients;

- (QMailElement *)initWithTitle:(NSString *)title subject:(NSString *)subject messageBody:(NSString *)messageBody toRecipients:(NSArray *)toRecipients ccRecipients:(NSArray *)ccRecipients bccRecipients:(NSArray *)bccRecipients;

- (void)selected:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller indexPath:(NSIndexPath *)path;

@end
