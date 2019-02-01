//
//  ViewController.m
//  CustomMultipleWebViewExample
//
//  Created by tigi on 01/02/2019.
//  Copyright © 2019 tigi. All rights reserved.
//

#import "ViewController.h"

#import "CustomMultipleWebViewController.h"

@interface ViewController ()

@property(nonatomic, readwrite) CustomMultipleWebViewController *customMultipleWebViewController;

@end

@implementation ViewController
{
    BOOL misFirstAppear;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor grayColor]];
    
    misFirstAppear = YES;
    _customMultipleWebViewController = [[CustomMultipleWebViewController alloc] initWithURL:[NSURL URLWithString:@"https://www.payco.com"]];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (misFirstAppear)
    {
        [self presentViewController:_customMultipleWebViewController animated:NO completion:nil];
        misFirstAppear = NO;
    }
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    [_customMultipleWebViewController.view setFrame:self.view.frame];
}

@end
