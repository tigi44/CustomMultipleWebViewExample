//
//  CMWebViewController+WKUIDelegate.m
//  CustomMultipleWebViewExample
//
//  Created by tigi on 08/02/2019.
//  Copyright © 2019 tigi. All rights reserved.
//


#import "CMWebViewController+WKUIDelegate.h"


static CGFloat kAnimateWebViewDuration = 0.5f;

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
        [self animateNewWebView:sNewWebView siblingWebView:aWebView];
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


#pragma mark - PRIVATE


- (void)animateNewWebView:(WKWebView *)aNewWebView siblingWebView:(WKWebView *)aSiblingSubview
{
    if (aNewWebView)
    {
        [UIView transitionWithView:self.view
                          duration:kAnimateWebViewDuration
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:nil
                        completion:nil];
    }
}

@end
