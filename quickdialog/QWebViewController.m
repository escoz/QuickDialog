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
- (CGImageRef)createBackArrowImageRef;
- (CGImageRef)createForwardArrowImageRef;


@end

@implementation QWebViewController {
    UIBarButtonItem * _btBack;
    UIBarButtonItem * _btForward;
    BOOL _firstPageFinished;
    BOOL _previousToolbarState;
}
- (QWebViewController *)initWithUrl:(NSString *)url {

    self = [super init];
    if (self!=nil){
        _webView = [[UIWebView alloc] init];
        _webView.delegate = self;
        _webView.scalesPageToFit = YES;
        _url = url;
        self.view = _webView;
        
        UIImage *backImage = [[UIImage alloc] initWithCGImage:[self createBackArrowImageRef]];
        UIImage *forwardImage = [[UIImage alloc] initWithCGImage:[self createForwardArrowImageRef]];
        _btBack = [[UIBarButtonItem alloc] initWithImage:backImage style:UIBarButtonItemStylePlain target:self action:@selector(actionRewind)];
        _btForward = [[UIBarButtonItem alloc] initWithImage:forwardImage style:UIBarButtonItemStylePlain target:self action:@selector(actionForward)];
        
        _btBack.enabled = NO;
        _btForward.enabled = NO;

        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated {
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
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
    _previousToolbarState = self.navigationController.toolbarHidden;
    self.navigationController.toolbarHidden = NO;
    self.navigationController.toolbar.tintColor = self.navigationController.navigationBar.tintColor;

    UIBarButtonItem *spacer1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spacer1.width = 30;
    UIBarButtonItem *spacer2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spacer2.width = 30;
    self.toolbarItems = [NSArray arrayWithObjects:
            _btBack,
            spacer1,
            _btForward,
            [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
            [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(actionRefresh)],
            spacer2,        
            [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(actionGoToSafari)],
            nil];
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [indicator startAnimating];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:indicator];
    self.title = @"Loading";
    if (_firstPageFinished==YES){
        _btBack.enabled = YES;
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.navigationItem.rightBarButtonItem = nil;
    self.title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    _firstPageFinished = YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    if (error.code==-999)
        return;
    self.navigationItem.rightBarButtonItem = nil;
    self.title = @"Error";
    [_webView loadHTMLString:[NSString stringWithFormat:@"<html style='margin:2em'><font size=+5>%@</font></html>", [error localizedDescription]] baseURL:nil];
}


- (CGContextRef)createContext
{
   CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
   CGContextRef context = CGBitmapContextCreate(nil,27,27,8,0, colorSpace,kCGImageAlphaPremultipliedLast);
   CFRelease(colorSpace);
   return context;
}

- (CGImageRef)createBackArrowImageRef
{
   CGContextRef context = [self createContext];
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
   return image;
}

- (CGImageRef)createForwardArrowImageRef
{
   CGContextRef context = [self createContext];
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
   return image;
}

@end