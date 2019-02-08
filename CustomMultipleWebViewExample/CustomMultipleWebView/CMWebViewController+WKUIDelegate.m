//
//  CMWebViewController+WKUIDelegate.m
//  CustomMultipleWebViewExample
//
//  Created by tigi on 08/02/2019.
//  Copyright © 2019 tigi. All rights reserved.
//

#import "CMWebViewController+WKUIDelegate.h"


@interface CMWebViewController()

- (WKWebView *)createWebViewWithConfiguration:(WKWebViewConfiguration *)aConfiguration navigationAction:(WKNavigationAction *)aNavigationAction;
- (void)closeWebView:(WKWebView *)aClosingWebView;

@end

@implementation CMWebViewController (WKUIDelegate)

- (WKWebView *)webView:(WKWebView *)aWebView createWebViewWithConfiguration:(WKWebViewConfiguration *)aConfiguration forNavigationAction:(WKNavigationAction *)aNavigationAction windowFeatures:(WKWindowFeatures *)aWindowFeatures
{
    WKWebView *sNewWebView;
    
    if (!aNavigationAction.targetFrame.isMainFrame)
    {
        sNewWebView = [self createWebViewWithConfiguration:aConfiguration navigationAction:aNavigationAction];
        [self.view addSubview:sNewWebView];
    }
    else
    {
        sNewWebView = nil;
        [aWebView loadRequest:aNavigationAction.request];
    }
    
    return sNewWebView;
}

- (void)webViewDidClose:(WKWebView *)aWebView
{
    [self closeWebView:aWebView];
}

@end
