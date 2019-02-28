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


@interface CMBaseWKWebViewController ()

@end

@implementation CMBaseWKWebViewController


#pragma mark - INIT


- (instancetype)initWithURL:(NSURL *)aURL
{
    self = [super initWithNibName:nil bundle:nil];
    
    if(self)
    {
        [self.view setBackgroundColor:[UIColor whiteColor]];
        
        [self setupWebView];
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
}


#pragma mark - SETUP


- (void)setupWebView
{
//    _webView = [[CMProgressWebView alloc] initWithFrame:CGRectZero];
    _webView = [[CMProgressWebView alloc] init];
    [_webView setNavigationDelegate:self];
    [_webView setUIDelegate:self];
    
    [self.view addSubview:_webView];
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
