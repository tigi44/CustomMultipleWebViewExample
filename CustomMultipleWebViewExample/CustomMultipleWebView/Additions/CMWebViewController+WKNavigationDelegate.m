//
//  CMWebViewController+WKNavigationDelegate.m
//  CustomMultipleWebViewExample
//
//  Created by tigi on 26/02/2019.
//  Copyright © 2019 tigi. All rights reserved.
//

#import "CMWebViewController+WKNavigationDelegate.h"
#import "CMTopView.h"


@interface CMWebViewController()

- (CMTopView *)topView;

@end

@implementation CMWebViewController (WKNavigationDelegate)

- (void)webView:(WKWebView *)aWebView didStartProvisionalNavigation:(WKNavigation *)aNavigation
{
    [super webView:aWebView didStartProvisionalNavigation:aNavigation];
    
    [[[self topView] urlTextField] setText:aWebView.URL.absoluteString];
    [[[self topView] refreshButton] setRefreshState:CMRefreshRefreshingState];
}

- (void)webView:(WKWebView *)aWebView didFailProvisionalNavigation:(WKNavigation *)aNavigation withError:(NSError *)aError
{
    [super webView:aWebView didFailProvisionalNavigation:aNavigation withError:aError];
    
    [[[self topView] refreshButton] setRefreshState:CMRefreshReadyState];
}

- (void)webView:(WKWebView *)aWebView didFinishNavigation:(WKNavigation *)aNavigation
{
    [super webView:aWebView didFinishNavigation:aNavigation];
    
    [[[self topView] refreshButton] setRefreshState:CMRefreshReadyState];
}

- (void)webView:(WKWebView *)aWebView didFailNavigation:(WKNavigation *)aNavigation withError:(NSError *)aError
{
    [super webView:aWebView didFailNavigation:aNavigation withError:aError];
    
    [[[self topView] refreshButton] setRefreshState:CMRefreshReadyState];
}

@end
