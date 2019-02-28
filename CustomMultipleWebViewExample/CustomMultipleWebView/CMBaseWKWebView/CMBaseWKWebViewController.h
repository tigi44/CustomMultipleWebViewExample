//
//  CMBaseWKWebViewController.h
//  CustomMultipleWebViewExample
//
//  Created by tigi on 01/02/2019.
//  Copyright © 2019 tigi. All rights reserved.
//

#import <WebKit/WebKit.h>
#import "CMProgressWebView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CMBaseWKWebViewController : UIViewController <WKNavigationDelegate, WKUIDelegate>

@property(nonatomic, readwrite) CMProgressWebView *webView;

- (instancetype)initWithURL:(nullable NSURL *)aURL NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
