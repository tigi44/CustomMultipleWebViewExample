//
//  CMProgressWebView.h
//  CustomMultipleWebViewExample
//
//  Created by tigi on 28/02/2019.
//  Copyright © 2019 tigi. All rights reserved.
//

#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CMProgressWebView : WKWebView

@property(nonatomic, readwrite) UIProgressView *loadingProgressView;

- (instancetype)initWithFrame:(CGRect)aFrame configuration:(nullable WKWebViewConfiguration *)aConfiguration NS_DESIGNATED_INITIALIZER;

- (void)showLoadingProgressView;
- (void)hideLoadingProgressView;

@end

NS_ASSUME_NONNULL_END
