//
//  CMWebViewController.m
//  CustomMultipleWebViewExample
//
//  Created by tigi on 01/02/2019.
//  Copyright © 2019 tigi. All rights reserved.
//

#import "CMWebViewController.h"

#import "CMWebViewController+WKNavigationDelegate.h"
#import "CMWebViewController+WKUIDelegate.h"
#import "CMWebViewController+UITextFieldDelegate.h"
#import "CMWebViewController+TabOverView.h"


@interface CMWebViewController ()

@property(nonatomic, assign) CMWebViewPageType pageType;
@property(nonatomic, readwrite) CMTopView *topView;
@property(nonatomic, readwrite) NSMutableArray<WKWebView *> *webViews;

@property(nonatomic, readwrite) UICollectionView *tabOverViewCollectionView;

- (void)closeWebViewController;
- (void)addProgressObserver:(WKWebView *)aWebView;
- (void)removeProgressObserver:(WKWebView *)aWebView;

@end

@implementation CMWebViewController


#pragma mark - OVERRIDE


- (instancetype)initWithURL:(NSURL *)aURL pageType:(CMWebViewPageType)aPageType
{
    self = [super initWithURL:aURL];
    if (self) {
        _webViews = [[NSMutableArray alloc] init];
        _pageType = aPageType;
        [self setupTopView];
        
        switch (_pageType) {
            case WebViewSinglePageType:
                [self setupTapOverViewCollectionView];
                break;
            case WebViewMultiplePageType:
                [_topView.tabOverViewButton setHidden:YES];
                break;
        }
    }
    return self;
}

- (instancetype)initWithURL:(NSURL *)aURL
{
    return [self initWithURL:aURL pageType:WebViewSinglePageType];
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
    
    [self activeNewWebView:self.webView];
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
    
    UIEdgeInsets sSafeAreaInsets = [[[UIApplication sharedApplication] keyWindow] safeAreaInsets];
    
    [_topView setFrame:CGRectMake(0, sSafeAreaInsets.top, CGRectGetWidth(_topView.frame), CGRectGetHeight(_topView.frame))];
    [self.webView setFrame:CGRectMake(0, CGRectGetMaxY(_topView.frame), CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - CGRectGetMaxY(_topView.frame) - sSafeAreaInsets.bottom)];
    [self.loadingProgressView setFrame:CGRectMake(CGRectGetMinX(_topView.urlTextField.frame), CGRectGetMinY(_topView.frame) + CGRectGetMaxY(_topView.urlTextField.frame) - CGRectGetHeight(self.loadingProgressView.frame), CGRectGetWidth(_topView.urlTextField.frame), 0)];
    
    [self layoutTapOverViewCollectionView];
}


#pragma mark - private


- (void)setupTopView
{
    _topView = [[CMTopView alloc] initWithFrame:CGRectZero];
    
    [[_topView urlTextField] setDelegate:self];
    [[_topView tabOverViewButton] addTarget:self action:@selector(actionTabOverViewButton:) forControlEvents:UIControlEventTouchUpInside];
    [[_topView closeButton] addTarget:self action:@selector(closeWebViewController) forControlEvents:UIControlEventTouchUpInside];
    
    [_topView sizeToFit];
    [_topView layoutIfNeeded];

    [self.view addSubview:_topView];
}

- (void)activeNewWebView:(WKWebView *)aNewWebView
{
    if (aNewWebView && ![_webViews containsObject:aNewWebView])
    {
        NSInteger sNewWebViewIndex = ([_webViews containsObject:self.webView]) ? [_webViews indexOfObject:self.webView] + 1 : 0;
        [_webViews insertObject:aNewWebView atIndex:sNewWebViewIndex];
        self.webView = aNewWebView;
        [self showActiveWebView];
        [self updateTabOverViewButton];
        
        if (sNewWebViewIndex > 0)
        {
            [self addProgressObserver:self.webView];
        }
    }
}

- (void)showActiveWebView
{
    BOOL sIsFrontOfActive = NO;
    
    for (WKWebView *sWebView in self.webViews)
    {
        [sWebView setHidden:sIsFrontOfActive];
        
        if (!sIsFrontOfActive && sWebView == self.webView)
        {
            sIsFrontOfActive = YES;
        }
    }
}

- (void)closeWebView:(WKWebView *)aClosingWebView
{
    if ([_webViews count] > 1)
    {
        if ([_webViews containsObject:aClosingWebView])
        {
            [_webViews removeObject:aClosingWebView];
            [aClosingWebView removeFromSuperview];
            [self removeProgressObserver:aClosingWebView];
            aClosingWebView = nil;
            
            self.webView = [_webViews lastObject];
        }
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


@end
