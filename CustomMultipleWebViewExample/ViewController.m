//
//  ViewController.m
//  CustomMultipleWebViewExample
//
//  Created by tigi on 01/02/2019.
//  Copyright © 2019 tigi. All rights reserved.
//

#import "ViewController.h"

#import "CMWebViewController.h"

@interface ViewController ()

@property(nonatomic, readwrite) UIButton *openBaseWebViewButton;
@property(nonatomic, readwrite) UIButton *openSinglePageWebViewButton;
@property(nonatomic, readwrite) UIButton *openMultiplePageWebViewButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor grayColor]];
    [self setupOpenBaseWebViewButton];
    [self setupOpenSinglePageWebViewButton];
    [self setupOpenMultiplePageWebViewButton];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    CGFloat sGapBetweenButtons = 200.f;
    
    CGFloat sPositionHorizontalCenter = self.view.frame.size.width / 2;
    CGFloat sPositionVerticalCenter = self.view.frame.size.height / 2;
    
    CGFloat sWidthBaseButton = CGRectGetWidth(_openBaseWebViewButton.frame);
    CGFloat sHeightBaseButton = CGRectGetHeight(_openBaseWebViewButton.frame);
    CGFloat sWidthSinglePageButton = CGRectGetWidth(_openSinglePageWebViewButton.frame);
    CGFloat sHeightSinglePageButton = CGRectGetHeight(_openSinglePageWebViewButton.frame);
    CGFloat sWidthMultiplePageButton = CGRectGetWidth(_openMultiplePageWebViewButton.frame);
    CGFloat sHeightMultiplePageButton = CGRectGetHeight(_openMultiplePageWebViewButton.frame);
    
    [_openBaseWebViewButton setFrame:CGRectMake(sPositionHorizontalCenter - sWidthBaseButton / 2, sPositionVerticalCenter - (sHeightBaseButton + sGapBetweenButtons) / 2, sWidthBaseButton, sHeightBaseButton)];
    [_openSinglePageWebViewButton setFrame:CGRectMake(sPositionHorizontalCenter - sWidthSinglePageButton / 2, sPositionVerticalCenter - (sHeightSinglePageButton) / 2, sWidthSinglePageButton, sHeightSinglePageButton)];
    [_openMultiplePageWebViewButton setFrame:CGRectMake(sPositionHorizontalCenter - sWidthMultiplePageButton / 2, sPositionVerticalCenter - (sHeightMultiplePageButton - sGapBetweenButtons) / 2, sWidthMultiplePageButton, sHeightMultiplePageButton)];
}


#pragma mark - SETUP


- (void)setupOpenBaseWebViewButton
{
    _openBaseWebViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [_openBaseWebViewButton setBackgroundColor:[UIColor whiteColor]];
    //    [_openBaseWebViewButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_openBaseWebViewButton setTitle:@"Open a BaseWebView" forState:UIControlStateNormal];
    [_openBaseWebViewButton addTarget:self action:@selector(openBaseWebView:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_openBaseWebViewButton];
    
    [_openBaseWebViewButton sizeToFit];
}

- (void)setupOpenSinglePageWebViewButton
{
    _openSinglePageWebViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_openSinglePageWebViewButton setBackgroundColor:[UIColor whiteColor]];
//    [_openSinglePageWebViewButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_openSinglePageWebViewButton setTitle:@"Open a SinglePageWebView" forState:UIControlStateNormal];
    [_openSinglePageWebViewButton addTarget:self action:@selector(openSinglePageWebView:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_openSinglePageWebViewButton];
    
    [_openSinglePageWebViewButton sizeToFit];
}

- (void)setupOpenMultiplePageWebViewButton
{
    _openMultiplePageWebViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_openMultiplePageWebViewButton setBackgroundColor:[UIColor whiteColor]];
//    [_openMultiplePageWebViewButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_openMultiplePageWebViewButton setTitle:@"Open a multiplePageWebView" forState:UIControlStateNormal];
    [_openMultiplePageWebViewButton addTarget:self action:@selector(openMultiplePageWebView:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_openMultiplePageWebViewButton];
    
    [_openMultiplePageWebViewButton sizeToFit];
}


#pragma mark - PRIVATE


- (void)openBaseWebView:(id)aSender
{
    CMBaseWKWebViewController *sWebView = [[CMBaseWKWebViewController alloc] initWithURL:[NSURL URLWithString:@"https://www.payco.com"]];
    
    [self presentViewController:sWebView animated:YES completion:nil];
}

- (void)openSinglePageWebView:(id)aSender
{
    CMWebViewController *sWebView = [[CMWebViewController alloc] initWithURL:[NSURL URLWithString:@"https://www.payco.com"]];
    [sWebView setPageType:WebViewSinglePageType];
    
    [self presentViewController:sWebView animated:YES completion:nil];
}

- (void)openMultiplePageWebView:(id)aSender
{
    CMWebViewController *sWebView = [[CMWebViewController alloc] initWithURL:[NSURL URLWithString:@"https://www.payco.com"]];
    [sWebView setPageType:WebViewMultiplePageType];
    
    [self presentViewController:sWebView animated:YES completion:nil];
}

@end
