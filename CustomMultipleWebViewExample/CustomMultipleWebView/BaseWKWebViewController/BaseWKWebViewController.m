//
//  BaseWKWebViewController.m
//  CustomMultipleWebViewExample
//
//  Created by tigi on 01/02/2019.
//  Copyright © 2019 tigi. All rights reserved.
//

#import "BaseWKWebViewController.h"
#import "WKWebViewPoolHandler.h"

#import "BaseWKWebViewController+WKNavigationDelegate.h"
#import "BaseWKWebViewController+WKUIDelegate.h"


@interface BaseWKWebViewController ()

@property(nonatomic, readwrite) WKWebView *webView;
@property(nonatomic, readwrite) WKWebViewConfiguration *webViewConfiguration;

@end

@implementation BaseWKWebViewController
{
    NSURL *mTargetURL;
}


#pragma mark - INIT


- (instancetype)initWithURL:(NSURL *)aURL
{
    self = [super initWithNibName:nil bundle:nil];
    
    if(self)
    {
        mTargetURL = aURL;
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
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self setupWebView];
    [self loadTargetURL];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    [self.webView setFrame:self.view.bounds];
}


#pragma mark - SETUP


- (void)setupWebView
{
    [self setupWebViewConfiguration];
    
    _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:_webViewConfiguration];
    
    [_webView setAllowsBackForwardNavigationGestures:YES];
    [_webView setNavigationDelegate:self];
    [_webView setUIDelegate:self];
    
    [self.view addSubview:_webView];
}

- (void)setupWebViewConfiguration
{
    if (_webViewConfiguration == nil)
    {
        _webViewConfiguration = [[WKWebViewConfiguration alloc] init];
        _webViewConfiguration.processPool = [WKWebViewPoolHandler pool];
        _webViewConfiguration.preferences.javaScriptCanOpenWindowsAutomatically = YES;
    }
}


#pragma mark - PRIVATE


- (void)loadTargetURL
{
    if(mTargetURL)
    {
        [_webView loadRequest:[NSMutableURLRequest requestWithURL:mTargetURL]];
    }
}


@end
