//
//  CMBaseWKWebViewController+WKNavigationDelegate.m
//  CustomMultipleWebViewExample
//
//  Created by tigi on 01/02/2019.
//  Copyright © 2019 tigi. All rights reserved.
//

#import "CMBaseWKWebViewController+WKNavigationDelegate.h"


@interface CMBaseWKWebViewController()

- (void)showLoadingProgressView;
- (void)hideLoadingProgressView;

@end

@implementation CMBaseWKWebViewController (WKNavigationDelegate)

- (void)webView:(WKWebView *)aWebView decidePolicyForNavigationAction:(WKNavigationAction *)aNavigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))aDecisionHandler
{
    WKNavigationActionPolicy sPolicy = WKNavigationActionPolicyAllow;
    NSURL                    *sURL   = aNavigationAction.request.URL;

    NSLog(@"decidePolicyForNavigationAction : %@", sURL);
//    if([[sURL scheme] isEqualToString:@"http"])
//    {
//        //TODO : add scheme handle logic
//    }

    aDecisionHandler(sPolicy);
}

- (void)webView:(WKWebView *)aWebView didStartProvisionalNavigation:(null_unspecified WKNavigation *)aNavigation
{
    NSLog(@"didStartProvisionalNavigation : %@", aWebView.URL);
    
    [self showLoadingProgressView];
}

- (void)webView:(WKWebView *)aWebView didFailProvisionalNavigation:(null_unspecified WKNavigation *)aNavigation withError:(NSError *)aError
{
    NSLog(@"didFailProvisionalNavigation : %@, Error :%@", aWebView.URL, [aError description]);
    
    [self hideLoadingProgressView];
}

- (void)webView:(WKWebView *)aWebView didFinishNavigation:(null_unspecified WKNavigation *)aNavigation
{
    NSLog(@"didFinishNavigation : %@", aWebView.URL);
    
    [self hideLoadingProgressView];
}

- (void)webView:(WKWebView *)aWebView didFailNavigation:(WKNavigation *)aNavigation withError:(NSError *)aError
{
    NSLog(@"didFailNavigation : %@, Error :%@", aWebView.URL, [aError description]);
    [self hideLoadingProgressView];
}

@end
