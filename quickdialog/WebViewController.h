//
//  Created by escoz on 7/12/11.
//
//  To change this template use File | Settings | File Templates.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface WebViewController : UIViewController <UIWebViewDelegate> {

@private
    UIWebView *_webView;
    NSString *_url;
}

- (WebViewController *)initWithUrl:(NSString *)string;
@end