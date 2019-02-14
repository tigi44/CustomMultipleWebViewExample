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
#import "CMWebViewController+TabOverView.h"


@interface CMWebViewController ()

@property(nonatomic, readwrite) NSMutableArray<WKWebView *> *webViews;
@property(nonatomic, readwrite) WKWebView                   *activeWebView;

@property(nonatomic, readwrite) UIButton *tabOverViewButton;
@property(nonatomic, readwrite) UICollectionView *tabOverViewCollectionView;

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
        _webViews = [[NSMutableArray alloc] init];
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
}

- (void)viewDidAppear:(BOOL)aAnimated
{
    [super viewDidAppear:aAnimated];
    
    if (_pageType == WebViewSinglePageType)
    {
        [self setupTabOverView];
    }
    
    [self activeNewWebView:self.webView];
    
    [self.view setNeedsLayout];
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

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
}


#pragma mark - private


- (void)activeNewWebView:(WKWebView *)aNewWebView
{
    if (aNewWebView)
    {
        [_webViews addObject:aNewWebView];
        _activeWebView = aNewWebView;
        
        [self updateTabOverViewButton];
        
        if (aNewWebView != self.webView)
            [self addProgressObserver:_activeWebView];
    }
}

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
