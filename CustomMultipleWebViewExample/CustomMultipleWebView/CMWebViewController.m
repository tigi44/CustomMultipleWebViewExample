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
        [self setupWebViewLayout:self.webView];
        
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
    
    [self addNewWebView:self.webView];
    [self showActiveWebView:self.webView];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
}

- (void)setupWebViewLayout
{
    // override
}


#pragma mark - setup


- (void)setupWebViewLayout:(CMProgressWebView *)aWebView
{
    UILayoutGuide *sGuide = self.view.safeAreaLayoutGuide;
    aWebView.translatesAutoresizingMaskIntoConstraints = NO;
    [aWebView.leadingAnchor constraintEqualToAnchor:sGuide.leadingAnchor].active = YES;
    [aWebView.trailingAnchor constraintEqualToAnchor:sGuide.trailingAnchor].active = YES;
    [aWebView.topAnchor constraintEqualToAnchor:_topToolBar.bottomAnchor].active = YES;
    [aWebView.bottomAnchor constraintEqualToAnchor:_bottomToolBar.topAnchor].active = YES;
}

- (void)setupTopToolBar
{
    _topToolBar = [[CMTopToolBar alloc] initWithFrame:CGRectZero];
    
    [[_topToolBar urlTextField] setDelegate:self];
    [[[_topToolBar urlTextField] refreshButton] setDelegate:self];
    
    __weak typeof(self) weakSelf = self;
    [_topToolBar setCloseBlock:^{
        [weakSelf closeWebViewController];
    }];
    
    [self.view addSubview:_topToolBar];
    
    _topToolBar.translatesAutoresizingMaskIntoConstraints = NO;
    [_topToolBar.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
    [_topToolBar.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
    [_topToolBar.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor].active = YES;
    [_topToolBar.heightAnchor constraintEqualToConstant:kTopToolBarHeight].active = YES;
}

- (void)setupBottomToolBar
{
    _bottomToolBar = [[CMBottomToolBar alloc] initWithFrame:CGRectZero];
    
    [_bottomToolBar setToolBarDelegate:self];
    
    [self.view addSubview:_bottomToolBar];
    
    _bottomToolBar.translatesAutoresizingMaskIntoConstraints = NO;
    [_bottomToolBar.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
    [_bottomToolBar.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
    [_bottomToolBar.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor].active = YES;
    [_bottomToolBar.heightAnchor constraintEqualToConstant:kBottomToolBarHeight].active = YES;
}


#pragma mark - private


- (void)addNewWebView:(CMProgressWebView *)aNewWebView
{
    if (aNewWebView && ![self.view.subviews containsObject:aNewWebView])
    {
        [self.view insertSubview:aNewWebView aboveSubview:self.webView];
    }
    
    if (aNewWebView && ![_webViews containsObject:aNewWebView])
    {
        NSInteger sNewWebViewIndex = ([_webViews containsObject:self.webView]) ? [_webViews indexOfObject:self.webView] + 1 : 0;
        [_webViews insertObject:aNewWebView atIndex:sNewWebViewIndex];
    }
}

- (void)showActiveWebView:(CMProgressWebView *)aActiveWebView
{
    self.webView = aActiveWebView;
    
    for (WKWebView *sWebView in self.webViews)
    {
        [sWebView setHidden:(sWebView != self.webView)];
    }
}

- (BOOL)closeWebView:(CMProgressWebView *)aClosingWebView
{
    BOOL sResult = NO;
    
    if ([_webViews containsObject:aClosingWebView])
    {
        [_webViews removeObject:aClosingWebView];
        [aClosingWebView removeFromSuperview];
        
        if (self.webView == aClosingWebView)
        {
            CMProgressWebView *sLastObject = [_webViews lastObject];
            if (sLastObject)
            {
                [self showActiveWebView:[_webViews lastObject]];
            }
            else
            {
                [self closeWebViewController];
            }
        }
        
        aClosingWebView = nil;
        sResult = YES;
    }
    
    return sResult;
}

- (CMProgressWebView *)createNewWebView:(WKWebViewConfiguration *)aConfiguration
{
    CMProgressWebView *sNewWebView = [[CMProgressWebView alloc] initWithFrame:CGRectZero configuration:aConfiguration];
    
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
    
    if (sNewWebView)
    {
        [self addNewWebView:sNewWebView];
        [self setupWebViewLayout:sNewWebView];
        [self showActiveWebView:sNewWebView];
    }
    
    return sNewWebView;
}


@end
