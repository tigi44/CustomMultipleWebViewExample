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
}

@end
