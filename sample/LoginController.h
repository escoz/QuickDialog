//
//  Created by escoz on 7/26/11.
//
//  To change this template use File | Settings | File Templates.
//


#import <UIKit/UIKit.h>
#import "../quickdialog/QuickDialogController+Loading.h"
#import "../quickdialog/QuickDialogStyleProvider.h"

@class QuickDialogController;
@protocol QuickDialogStyleProvider;

@interface LoginController : QuickDialogController <QuickDialogStyleProvider> {

}

+ (QRootElement *)createDetailsForm;
+ (QRootElement *)createLoginForm;
@end