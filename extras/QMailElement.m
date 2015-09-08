//
//  QMailElement.m
//  ConferencesBox
//
//  Created by Richard Huang on 2/16/13.
//  Copyright (c) 2013 ConferencesBox. All rights reserved.
//

#import "QMailElement.h"

@implementation QMailElement


- (QMailElement *)initWithTitle:(NSString *)title subject:(NSString *)subject messageBody:(NSString *)messageBody toRecipients:(NSArray *)toRecipients ccRecipients:(NSArray *)ccRecipients bccRecipients:(NSArray *)bccRecipients {
    self = [super init];
    if (self != nil) {
        _title = title;
        _subject = subject;
        _toRecipients = toRecipients;
        _ccRecipients = ccRecipients;
        _bccRecipients = bccRecipients;
    }
    return self;
}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    UITableViewCell *cell = [super getCellForTableView:tableView controller:controller];
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    return cell;
}


- (void)selected:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller indexPath:(NSIndexPath *)path {
    [self performAction];
	
    if([MFMailComposeViewController canSendMail]) {        
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        mc.mailComposeDelegate = self;
        [mc setTitle:_title];
        [mc setSubject:_subject];
        [mc setMessageBody:_messageBody isHTML:NO];
        [mc setToRecipients:_toRecipients];
        [mc setCcRecipients:_ccRecipients];
        [mc setBccRecipients:_bccRecipients];
        
        [controller displayViewController:mc];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Mail Accounts" message:@"Please set up a Mail account in order to send email." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            break;
        case MFMailComposeResultSaved:
            break;
        case MFMailComposeResultSent:
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    [controller dismissViewControllerAnimated:YES completion:NULL];
}
@end
