//
//  CMBaseWKWebViewController+WebViewProgress.h
//  CustomMultipleWebViewExample
//
//  Created by tigi on 08/02/2019.
//  Copyright © 2019 tigi. All rights reserved.
//

#import "CMBaseWKWebViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CMBaseWKWebViewController (WebViewProgress)

- (void)addProgressObserver:(WKWebView *)aWebView;
- (void)removeProgressObserver:(WKWebView *)aWebView;
- (void)showLoadingProgressView;
- (void)hideLoadingProgressView;

@end

NS_ASSUME_NONNULL_END
