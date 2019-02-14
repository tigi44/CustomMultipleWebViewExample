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
#import "CMBaseWKWebViewController+UITextFieldDelegate.h"
#import "CMBaseWKWebViewController+WebViewProgress.h"


CGFloat static kTopViewHeight = 50.f;

@interface CMBaseWKWebViewController ()

@property(nonatomic, readwrite) CMTopView *topView;
@property(nonatomic, readwrite) UIProgressView *loadingProgressView;
@property(nonatomic, readwrite) WKWebViewConfiguration *webViewConfiguration;

@end

@implementation CMBaseWKWebViewController


#pragma mark - INIT


- (instancetype)initWithURL:(NSURL *)aURL
{
    self = [super initWithNibName:nil bundle:nil];
    
    if(self)
    {
        [self.view setBackgroundColor:[UIColor whiteColor]];
        
        [self setupTopView];
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
    
    [_topView setFrame:CGRectMake(0, sSafeAreaInsets.top, CGRectGetWidth(_topView.frame), CGRectGetHeight(_topView.frame))];
    [_webView setFrame:CGRectMake(0, CGRectGetMaxY(_topView.frame), CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - CGRectGetMaxY(_topView.frame) - sSafeAreaInsets.bottom)];
    
    if (kTopViewHeight > 0)
    {
        [_loadingProgressView setFrame:CGRectMake(CGRectGetMinX(_topView.urlTextField.frame), CGRectGetMinY(_topView.frame) + CGRectGetMaxY(_topView.urlTextField.frame) - CGRectGetHeight(_loadingProgressView.frame), CGRectGetWidth(_topView.urlTextField.frame), 0)];
    }
    else
    {
        [_loadingProgressView setFrame:CGRectMake(0, CGRectGetMinY(_webView.frame) - CGRectGetHeight(_loadingProgressView.frame), CGRectGetWidth(_webView.frame), 0)];
    }
}

- (void)dealloc
{
    [self removeProgressObserver:_webView];
}

- (WKWebViewConfiguration *)webViewConfiguration
{
    if (_webViewConfiguration == nil)
    {
        _webViewConfiguration = [[WKWebViewConfiguration alloc] init];
        _webViewConfiguration.processPool = [CMWKProcessPoolHandler pool];
        _webViewConfiguration.preferences.javaScriptCanOpenWindowsAutomatically = YES;
    }
    
    return _webViewConfiguration;
}


#pragma mark - SETUP


- (void)setupTopView
{
    _topView = [[CMTopView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), kTopViewHeight)];
    
    [[_topView closeButton] addTarget:self action:@selector(closeWebViewController) forControlEvents:UIControlEventTouchUpInside];
    [[_topView urlTextField] setDelegate:self];
    
    [_topView sizeToFit];
    [_topView layoutIfNeeded];
    
    [self.view addSubview:_topView];
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
    _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:self.webViewConfiguration];
    
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
