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
#import "CMWebViewController+ToolBarDelegate.h"


static CGFloat kTopToolBarHeight = 50.f;
static CGFloat kBottomToolBarHeight = 44.f;

@interface CMWebViewController ()

@property(nonatomic, assign) CMWebViewPageType pageType;

@property(nonatomic, readwrite) CMTopToolBar *topToolBar;
@property(nonatomic, readwrite) CMBottomToolBar *bottomToolBar;
@property(nonatomic, readwrite) NSMutableArray<CMProgressWebView *> *webViews;

@property(nonatomic, readwrite) UICollectionView *tabOverViewCollectionView;

- (void)closeWebViewController;

@end

@implementation CMWebViewController


#pragma mark - OVERRIDE


- (instancetype)initWithURL:(NSURL *)aURL pageType:(CMWebViewPageType)aPageType
{
    self = [super initWithURL:aURL];
    if (self) {
        _webViews = [[NSMutableArray alloc] init];
        _pageType = aPageType;
        [self setupTopToolBar];
        [self setupBottomToolBar];
        
        switch (_pageType) {
            case WebViewSinglePageType:
                [self setupTapOverViewCollectionView];
                break;
            case WebViewMultiplePageType:
                [_bottomToolBar setToolBarType:CMBottomToolBarTypeNoneTab];
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

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    UIEdgeInsets sSafeAreaInsets = [[[UIApplication sharedApplication] keyWindow] safeAreaInsets];
    
    [_topToolBar setFrame:CGRectMake(0, sSafeAreaInsets.top, CGRectGetWidth(_topToolBar.frame), CGRectGetHeight(_topToolBar.frame))];
    [self.webView setFrame:CGRectMake(0, CGRectGetMaxY(_topToolBar.frame), CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - CGRectGetMaxY(_topToolBar.frame) - CGRectGetHeight(_bottomToolBar.frame) - sSafeAreaInsets.bottom)];
    [_bottomToolBar setFrame:CGRectMake(0, CGRectGetMaxY(self.webView.frame), CGRectGetWidth(_bottomToolBar.frame), CGRectGetHeight(_bottomToolBar.frame))];
    
    [self layoutTapOverViewCollectionView];
}


#pragma mark - setup


- (void)setupTopToolBar
{
    _topToolBar = [[CMTopToolBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), kTopToolBarHeight)];
    
    [[_topToolBar urlTextField] setDelegate:self];
    [[[_topToolBar urlTextField] refreshButton] setDelegate:self];
    
    __weak typeof(self) weakSelf = self;
    [_topToolBar setCloseBlock:^{
        [weakSelf closeWebViewController];
    }];
    
    [self.view addSubview:_topToolBar];
}

- (void)setupBottomToolBar
{
    _bottomToolBar = [[CMBottomToolBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), kBottomToolBarHeight)];
    [_bottomToolBar setToolBarDelegate:self];
    
    [self.view addSubview:_bottomToolBar];
}


#pragma mark - private


- (void)activeNewWebView:(CMProgressWebView *)aNewWebView
{
    if (aNewWebView && ![_webViews containsObject:aNewWebView])
    {
        NSInteger sNewWebViewIndex = ([_webViews containsObject:self.webView]) ? [_webViews indexOfObject:self.webView] + 1 : 0;
        [_webViews insertObject:aNewWebView atIndex:sNewWebViewIndex];
        self.webView = aNewWebView;
        [self showActiveWebView];
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

- (BOOL)closeWebView:(CMProgressWebView *)aClosingWebView
{
    BOOL sResult = NO;
    
    if ([_webViews count] > 1)
    {
        if ([_webViews containsObject:aClosingWebView])
        {
            [_webViews removeObject:aClosingWebView];
            [aClosingWebView removeFromSuperview];
            
            if (self.webView == aClosingWebView)
            {
                self.webView = [_webViews lastObject];
            }
            
            aClosingWebView = nil;
            sResult = YES;
        }
    }
    
    return sResult;
}

- (CMProgressWebView *)createNewWebView:(WKWebViewConfiguration *)aConfiguration
{
    CMProgressWebView *sNewWebView = [[CMProgressWebView alloc] initWithFrame:[self.webView frame] configuration:aConfiguration];
    
    [sNewWebView setNavigationDelegate:self];
    [sNewWebView setUIDelegate:self];
    
    return sNewWebView;
}

- (CMProgressWebView *)createNewWebViewController:(WKNavigationAction *)aNavigationAction
{
    NSURL *sURL = aNavigationAction.request.URL;
    CMWebViewController *sNewWebViewController = [[CMWebViewController alloc] initWithURL:sURL pageType:WebViewMultiplePageType];
    
    [self presentViewController:sNewWebViewController animated:YES completion:nil];
    
    return nil;
}

- (WKWebView *)createWebViewWithConfiguration:(WKWebViewConfiguration *)aConfiguration navigationAction:(WKNavigationAction *)aNavigationAction
{
    CMProgressWebView *sNewWebView;
    
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
