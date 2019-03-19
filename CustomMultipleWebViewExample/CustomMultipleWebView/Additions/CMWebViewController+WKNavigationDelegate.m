//
//  CMWebViewController+WKNavigationDelegate.m
//  CustomMultipleWebViewExample
//
//  Created by tigi on 26/02/2019.
//  Copyright © 2019 tigi. All rights reserved.
//

#import "CMWebViewController+WKNavigationDelegate.h"


@interface CMWebViewController()

@property(nonatomic, readwrite) CMTopToolBar *topToolBar;
@property(nonatomic, readwrite) CMBottomToolBar *bottomToolBar;

@end

@implementation CMWebViewController (WKNavigationDelegate)

- (void)webView:(WKWebView *)aWebView didStartProvisionalNavigation:(WKNavigation *)aNavigation
{
    [super webView:aWebView didStartProvisionalNavigation:aNavigation];
    
    [[[self topToolBar] urlTextField] setText:aWebView.URL.absoluteString];
    [[[[self topToolBar] urlTextField] refreshButton] setRefreshState:CMRefreshRefreshingState];
}

- (void)webView:(WKWebView *)aWebView didFailProvisionalNavigation:(WKNavigation *)aNavigation withError:(NSError *)aError
{
    [super webView:aWebView didFailProvisionalNavigation:aNavigation withError:aError];
    
    [[[[self topToolBar] urlTextField] refreshButton] setRefreshState:CMRefreshReadyState];
}

- (void)webView:(WKWebView *)aWebView didFinishNavigation:(WKNavigation *)aNavigation
{
    [super webView:aWebView didFinishNavigation:aNavigation];
    
    [[[[self topToolBar] urlTextField] refreshButton] setRefreshState:CMRefreshReadyState];
    [self enableToolBarButton];
}

- (void)webView:(WKWebView *)aWebView didFailNavigation:(WKNavigation *)aNavigation withError:(NSError *)aError
{
    [super webView:aWebView didFailNavigation:aNavigation withError:aError];
    
    [[[[self topToolBar] urlTextField] refreshButton] setRefreshState:CMRefreshReadyState];
    [self enableToolBarButton];
}


#pragma mark - private


- (void)enableToolBarButton
{
    [[[self bottomToolBar] barButtonItemAtIndex:CMBottomToolBarButtonItemBack] setEnabled:[[self webView] canGoBack]];
    [[[self bottomToolBar] barButtonItemAtIndex:CMBottomToolBarButtonItemForward] setEnabled:[[self webView] canGoForward]];
}

@end
