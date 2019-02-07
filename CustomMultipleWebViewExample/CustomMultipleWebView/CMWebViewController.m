//
//  CMWebViewController.m
//  CustomMultipleWebViewExample
//
//  Created by tigi on 01/02/2019.
//  Copyright © 2019 tigi. All rights reserved.
//

#import "CMWebViewController.h"

#import "CMBaseWKWebViewController+WKNavigationDelegate.h"
#import "CMBaseWKWebViewController+WKUIDelegate.h"

@interface CMWebViewController ()

@property(nonatomic, readwrite) NSMutableArray<WKWebView *> *webViews;
@property(nonatomic, readwrite) WKWebView                   *activeWebView;

- (void)closeWebViewController;

@end

@implementation CMWebViewController


#pragma mark - OVERRIDE


- (instancetype)initWithURL:(NSURL *)aURL
{
    self = [super initWithURL:aURL];
    if (self) {
        [self setupWebViews];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)aAnimated
{
    [super viewWillAppear:aAnimated];
    
    [self setActiveWebView:self.webView];
}


#pragma mark - setup


- (void)setupWebViews
{
    _webViews = [[NSMutableArray alloc] init];
    [_webViews addObject:self.webView];
}


#pragma mark - private


- (WKWebView *)createWebViewWithConfiguration:(WKWebViewConfiguration *)aConfiguration
{
    WKWebView *sNewWebView = [[WKWebView alloc] initWithFrame:[self.webView frame] configuration:aConfiguration];
    
    [sNewWebView setAllowsBackForwardNavigationGestures:self.webView.allowsBackForwardNavigationGestures];
    [sNewWebView setNavigationDelegate:self];
    [sNewWebView setUIDelegate:self];
    
    [_webViews addObject:sNewWebView];
    _activeWebView = sNewWebView;
    
    return sNewWebView;
}

- (void)closeWebView:(WKWebView *)aClosingWebView
{
    if ([_webViews containsObject:aClosingWebView])
    {
        [_webViews removeObject:aClosingWebView];
        [aClosingWebView removeFromSuperview];
        aClosingWebView = nil;
        
        _activeWebView = [_webViews lastObject];
    }
    
    if ([_webViews count] <= 0 || _activeWebView == nil) {
        [self closeWebViewController];
    }
}


#pragma mark - WKUIDelegate


- (WKWebView *)webView:(WKWebView *)aWebView createWebViewWithConfiguration:(WKWebViewConfiguration *)aConfiguration forNavigationAction:(WKNavigationAction *)aNavigationAction windowFeatures:(WKWindowFeatures *)aWindowFeatures
{
    WKWebView *sNewWebView;
    
    if (!aNavigationAction.targetFrame.isMainFrame)
    {
        sNewWebView = [self createWebViewWithConfiguration:aConfiguration];
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
