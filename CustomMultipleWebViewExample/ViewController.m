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

@property(nonatomic, readwrite) UIButton *openWebViewButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor grayColor]];
    [self setupOpenWebViewButton];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    CGFloat sPositionHorizontalCenter = self.view.frame.size.width / 2;
    CGFloat sPositionVerticalCenter = self.view.frame.size.height / 2;
    CGFloat sButtonWidth = 200.f;
    CGFloat sButtonHeight = 200.f;
    
    [_openWebViewButton setFrame:CGRectMake(sPositionHorizontalCenter - sButtonWidth / 2, sPositionVerticalCenter - sButtonHeight / 2, sButtonWidth, sButtonHeight)];
}


#pragma mark - SETUP


- (void)setupOpenWebViewButton
{
    _openWebViewButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [_openWebViewButton addTarget:self action:@selector(openWebView:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_openWebViewButton];
}


#pragma mark - PRIVATE


- (void)openWebView:(id)aSender
{
    CMWebViewController *sWebView = [[CMWebViewController alloc] initWithURL:[NSURL URLWithString:@"https://www.payco.com"]];
    
    [self presentViewController:sWebView animated:YES completion:nil];
}

@end
