//                                
// Copyright 2011 ESCOZ Inc  - http://escoz.com
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

#import "QWebViewController.h"

@interface QWebViewController ()
- (UIImage *)createBackArrowImage;
- (UIImage *)createForwardArrowImage;


@end

@implementation QWebViewController {
    UIBarButtonItem * _btBack;
    UIBarButtonItem * _btForward;
    BOOL _firstPageFinished;
    BOOL _previousToolbarState;
    NSArray *_urlToolbarItems;
}
- (QWebViewController *)initWithHTML:(NSString *)html {
	
    self = [super init];
    if (self!=nil){
        _html = html;

        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)loadView {
    [super loadView];
    _webView = [[UIWebView alloc] init];
    _webView.delegate = self;
    _webView.scalesPageToFit = YES;
    self.view = _webView;

    UIImage *backImage = [self createBackArrowImage];
    UIImage *forwardImage = [self createForwardArrowImage];
    _btBack = [[UIBarButtonItem alloc] initWithImage:backImage style:UIBarButtonItemStylePlain target:self action:@selector(actionRewind)];
    _btForward = [[UIBarButtonItem alloc] initWithImage:forwardImage style:UIBarButtonItemStylePlain target:self action:@selector(actionForward)];

    _btBack.enabled = NO;
    _btForward.enabled = NO;

    UIBarButtonItem *spacer1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
  		spacer1.width = 30;
  		UIBarButtonItem *spacer2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
  		spacer2.width = 30;
    _urlToolbarItems = [NSArray arrayWithObjects:
              _btBack,
              spacer1,
              _btForward,
              [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
              [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(actionRefresh)],
              spacer2,
              [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(actionGoToSafari)],
              nil];
}


- (QWebViewController *)initWithUrl:(NSString *)url {

    self = [super init];
    if (self!=nil){
        _url = url;
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_webView stopLoading];
    [self.navigationController setToolbarHidden:_previousToolbarState animated:YES];
    _webView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}

- (void)actionRewind {
    [_webView goBack];
    _btForward.enabled = YES;

}

- (void)actionForward {
    [_webView goForward];
}

- (void)actionRefresh {
    [_webView reload];
}

- (void)actionGoToSafari {
    [[UIApplication sharedApplication] openURL:[_webView.request mainDocumentURL]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
	_previousToolbarState = self.navigationController.toolbarHidden;

	if (_html) {
        [_webView loadHTMLString:_html baseURL:nil];
		self.navigationController.toolbarHidden = YES;
        self.toolbarItems = nil;
	}
	else {
        NSURL *url = [_url hasPrefix:@"/"]? [NSURL fileURLWithPath:_url] : [NSURL URLWithString:_url];
        [_webView loadRequest:[NSURLRequest requestWithURL:url]];
		self.navigationController.toolbarHidden = NO;

        self.toolbarItems = _urlToolbarItems;
	}
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [indicator startAnimating];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:indicator];

    if (_url!=nil) {
        self.title = @"Loading";
    }
    if (_firstPageFinished==YES){
        _btBack.enabled = YES;
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.navigationItem.rightBarButtonItem = nil;
    NSString *titleFromHTML = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    if (titleFromHTML!=nil && ![titleFromHTML isEqualToString:@""])
        self.title = titleFromHTML;

    _firstPageFinished = YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    if (error.code==-999)
        return;
    self.navigationItem.rightBarButtonItem = nil;
    self.navigationItem.title = @"Error";
    [_webView loadHTMLString:[NSString stringWithFormat:@"<html style='margin:2em'><header><title>Error</title><header><body><h3>Unable to connect to the internet.</h3><p>%@</p><p><br/><br/>Try again: <br/><a href=\"%@\">%@</a></p></body></html>",[error localizedDescription], _url, _url] baseURL:nil];
}


- (UIImage *)createBackArrowImage
{
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGContextRef context = CGBitmapContextCreate(nil,27,27,8,0, colorSpace,kCGImageAlphaPremultipliedLast);
	CFRelease(colorSpace);
   CGColorRef fillColor = [[UIColor blackColor] CGColor];
   CGContextSetFillColor(context, (CGFloat *) CGColorGetComponents(fillColor));
   CGContextBeginPath(context);
   CGContextMoveToPoint(context, 8.0f, 13.0f);
   CGContextAddLineToPoint(context, 24.0f, 4.0f);
   CGContextAddLineToPoint(context, 24.0f, 22.0f);
   CGContextClosePath(context);
   CGContextFillPath(context);
   CGImageRef image = CGBitmapContextCreateImage(context);
   CGContextRelease(context);
   UIImage *ret = [UIImage imageWithCGImage:image];
   CGImageRelease(image);
    
   return ret;
}

- (UIImage *)createForwardArrowImage
{
   CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
   CGContextRef context = CGBitmapContextCreate(nil,27,27,8,0, colorSpace,kCGImageAlphaPremultipliedLast);
   CFRelease(colorSpace);
   CGColorRef fillColor = [[UIColor blackColor] CGColor];
   CGContextSetFillColor(context, (CGFloat *) CGColorGetComponents(fillColor));
   CGContextBeginPath(context);
   CGContextMoveToPoint(context, 24.0f, 13.0f);
   CGContextAddLineToPoint(context, 8.0f, 4.0f);
   CGContextAddLineToPoint(context, 8.0f, 22.0f);
   CGContextClosePath(context);
   CGContextFillPath(context);
   CGImageRef image = CGBitmapContextCreateImage(context);
   CGContextRelease(context);
   UIImage *ret = [UIImage imageWithCGImage:image];
   CGImageRelease(image);
    
   return ret;
}

@end
