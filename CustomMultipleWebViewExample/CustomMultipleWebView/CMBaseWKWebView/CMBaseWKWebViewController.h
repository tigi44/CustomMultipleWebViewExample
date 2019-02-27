//
//  CMBaseWKWebViewController.h
//  CustomMultipleWebViewExample
//
//  Created by tigi on 01/02/2019.
//  Copyright © 2019 tigi. All rights reserved.
//

#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CMBaseWKWebViewController : UIViewController <WKNavigationDelegate, WKUIDelegate>

@property(nonatomic, readonly) UIProgressView *loadingProgressView;
@property(nonatomic, readwrite) WKWebView *webView;

- (instancetype)initWithURL:(nullable NSURL *)aURL NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
