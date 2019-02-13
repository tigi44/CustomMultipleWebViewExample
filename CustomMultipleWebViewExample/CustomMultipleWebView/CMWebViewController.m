//
//  CMWebViewController.m
//  CustomMultipleWebViewExample
//
//  Created by tigi on 01/02/2019.
//  Copyright © 2019 tigi. All rights reserved.
//

#import "CMWebViewController.h"

#import "CMBaseWKWebViewController+WKNavigationDelegate.h"
#import "CMWebViewController+WKUIDelegate.h"


@interface CMWebViewController ()

@property(nonatomic, readwrite) NSMutableArray<WKWebView *> *webViews;
@property(nonatomic, readwrite) WKWebView                   *activeWebView;

- (void)closeWebViewController;
- (void)addProgressObserver:(WKWebView *)aWebView;
- (void)removeProgressObserver:(WKWebView *)aWebView;

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

- (void)dealloc
{
    for (WKWebView *sWebView in _webViews)
    {
        if (sWebView != self.webView)
        {
            [self removeProgressObserver:sWebView];
        }
    }
}


#pragma mark - setup


- (void)setupWebViews
{
    _webViews = [[NSMutableArray alloc] init];
    [_webViews addObject:self.webView];
}


#pragma mark - private


- (WKWebView *)createNewWebView:(WKWebViewConfiguration *)aConfiguration
{
    WKWebView *sNewWebView = [[WKWebView alloc] initWithFrame:[self.webView frame] configuration:aConfiguration];
    
    [sNewWebView setAllowsBackForwardNavigationGestures:self.webView.allowsBackForwardNavigationGestures];
    [sNewWebView setNavigationDelegate:self];
    [sNewWebView setUIDelegate:self];
    
    return sNewWebView;
}

- (WKWebView *)createNewWebViewController:(WKNavigationAction *)aNavigationAction
{
    NSURL *sURL = aNavigationAction.request.URL;
    CMWebViewController *sNewWebViewController = [[CMWebViewController alloc] initWithURL:sURL];
    
    [sNewWebViewController setPageType:WebViewMultiplePageType];
    
    [self presentViewController:sNewWebViewController animated:YES completion:nil];
    
    return nil;
}

- (void)activeNewWebView:(WKWebView *)aNewWebView
{
    if (aNewWebView)
    {
        [_webViews addObject:aNewWebView];
        _activeWebView = aNewWebView;
        
        [self addProgressObserver:_activeWebView];
    }
}

- (WKWebView *)createWebViewWithConfiguration:(WKWebViewConfiguration *)aConfiguration navigationAction:(WKNavigationAction *)aNavigationAction
{
    WKWebView *sNewWebView;
    
    switch (_pageType) {
        case WebViewSinglePageType:
            sNewWebView = [self createNewWebView:aConfiguration];
            break;
        case WebViewMultiplePageType:
            sNewWebView = [self createNewWebViewController:aNavigationAction];
            break;
    }
    
    [self activeNewWebView:sNewWebView];
    
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


@end
