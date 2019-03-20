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
}


#pragma mark - SETUP


- (void)setupWebView
{
    _webView = [[CMProgressWebView alloc] init];
    [_webView setNavigationDelegate:self];
    [_webView setUIDelegate:self];
    
    [self.view addSubview:_webView];
    
    [self setupWebViewLayout];
}

- (void)setupWebViewLayout
{
    _webView.translatesAutoresizingMaskIntoConstraints = NO;
    if (@available(iOS 11, *))
    {
        UILayoutGuide *sGuide = self.view.safeAreaLayoutGuide;
        [_webView.leadingAnchor constraintEqualToAnchor:sGuide.leadingAnchor].active = YES;
        [_webView.trailingAnchor constraintEqualToAnchor:sGuide.trailingAnchor].active = YES;
        [_webView.topAnchor constraintEqualToAnchor:sGuide.topAnchor].active = YES;
        [_webView.bottomAnchor constraintEqualToAnchor:sGuide.bottomAnchor].active = YES;
    }
    //    else
    //    {
    //        UILayoutGuide *sMargins = self.view.layoutMarginsGuide;
    //        [_webView.leadingAnchor constraintEqualToAnchor:sMargins.leadingAnchor].active = YES;
    //        [_webView.trailingAnchor constraintEqualToAnchor:sMargins.trailingAnchor].active = YES;
    //        [_webView.topAnchor constraintEqualToAnchor:self.topLayoutGuide.bottomAnchor].active = YES;
    //        [_webView.bottomAnchor constraintEqualToAnchor:self.bottomLayoutGuide.topAnchor].active = YES;
    //    }
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
