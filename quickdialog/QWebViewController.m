//
//  Created by escoz on 7/12/11.
//

#import "QWebViewController.h"


@implementation QWebViewController

- (QWebViewController *)initWithUrl:(NSString *)url {

    self = [super init];
    if (self!=nil){
        _webView = [[UIWebView alloc] init];
        _webView.delegate = self;
        _webView.scalesPageToFit = YES;

        _url = url;
        self.view = _webView;
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [_webView stopLoading];
    _webView = nil;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [indicator startAnimating];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:indicator];
    self.title = @"Loading";
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.navigationItem.rightBarButtonItem = nil;
    self.title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    self.navigationItem.rightBarButtonItem = nil;
    self.title = @"Error";
    [_webView loadHTMLString:[NSString stringWithFormat:@"<html><font size=+5>An error occurred:<br>%@</font></html>", [error localizedDescription]] baseURL:nil];
}


@end