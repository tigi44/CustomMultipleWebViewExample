//
//  CMBaseWKWebViewController.m
//  CustomMultipleWebViewExample
//
//  Created by tigi on 01/02/2019.
//  Copyright © 2019 tigi. All rights reserved.
//

#import "CMBaseWKWebViewController.h"
#import "CMWKProcessPoolHandler.h"

#import "CMBaseWKWebViewController+WKNavigationDelegate.h"
#import "CMBaseWKWebViewController+WKUIDelegate.h"
#import "CMBaseWKWebViewController+WebViewProgress.h"


@interface CMBaseWKWebViewController ()

@property(nonatomic, readwrite) UIProgressView *loadingProgressView;

@end

@implementation CMBaseWKWebViewController
{
    WKWebViewConfiguration *mWebViewConfiguration;
}


#pragma mark - INIT


- (instancetype)initWithURL:(NSURL *)aURL
{
    self = [super initWithNibName:nil bundle:nil];
    
    if(self)
    {
        [self.view setBackgroundColor:[UIColor whiteColor]];
        
        [self webViewConfiguration];
        [self setupWebView];
        [self setupLoadingProgressView];
        [self loadWebView:aURL];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    return [self initWithURL:nil];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    return [self initWithURL:nil];
}


#pragma mark - OVERRIDE


- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    UIEdgeInsets sSafeAreaInsets = [[[UIApplication sharedApplication] keyWindow] safeAreaInsets];
    
    [_webView setFrame:CGRectMake(0, sSafeAreaInsets.top, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - sSafeAreaInsets.top - sSafeAreaInsets.bottom)];
    [_loadingProgressView setFrame:CGRectMake(0, CGRectGetMinY(_webView.frame), CGRectGetWidth(_webView.frame), 0)];
}

- (void)dealloc
{
    [self removeProgressObserver:_webView];
}


#pragma mark - SETUP


- (WKWebViewConfiguration *)webViewConfiguration
{
    if (mWebViewConfiguration == nil)
    {
        mWebViewConfiguration = [[WKWebViewConfiguration alloc] init];
        mWebViewConfiguration.processPool = [CMWKProcessPoolHandler pool];
        mWebViewConfiguration.preferences.javaScriptCanOpenWindowsAutomatically = YES;
    }
    
    return mWebViewConfiguration;
}

- (void)setupLoadingProgressView
{
    _loadingProgressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    [_loadingProgressView setTrackTintColor:[UIColor clearColor]];
    [_loadingProgressView setTintColor:[UIColor redColor]];
    [_loadingProgressView setAlpha:0.f];
    [_loadingProgressView setClipsToBounds:YES];
    [_loadingProgressView.layer setCornerRadius:2.f];

    [self.view addSubview:_loadingProgressView];
}

- (void)setupWebView
{
    _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:mWebViewConfiguration];
    
    [_webView setAllowsBackForwardNavigationGestures:YES];
    [_webView setNavigationDelegate:self];
    [_webView setUIDelegate:self];
    
    [self.view addSubview:_webView];
    
    [self addProgressObserver:_webView];
}


#pragma mark - PRIVATE


- (void)loadWebView:(NSURL *)aURL
{
    if(aURL)
    {
        [_webView loadRequest:[NSMutableURLRequest requestWithURL:aURL]];
    }
}

- (void)closeWebViewController
{
    if ([self isKindOfClass:[UINavigationController class]])
    {
        [(UINavigationController *)self popViewControllerAnimated:YES];
    }
    else if(self.navigationController)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


@end
