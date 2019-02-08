//
//  CMBaseWKWebViewController+WebViewProgress.m
//  CustomMultipleWebViewExample
//
//  Created by tigi on 08/02/2019.
//  Copyright © 2019 tigi. All rights reserved.
//

#import "CMBaseWKWebViewController+WebViewProgress.h"


@interface CMBaseWKWebViewController()

- (UIProgressView *)loadingProgressView;

@end

@implementation CMBaseWKWebViewController (WebViewProgress)


#pragma mark - SHOW/HIDE LOADING PROGRESS


- (void)showLoadingProgressView
{
    [self.view bringSubviewToFront:[self loadingProgressView]];

    [UIView animateWithDuration:0.5f
                          delay:0.f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [[self loadingProgressView] setAlpha:1.f];
                     }
                     completion:nil];
}

- (void)hideLoadingProgressView
{
    [UIView animateWithDuration:0.5f
                          delay:0.5f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [[self loadingProgressView] setAlpha:0.f];
                     }
                     completion:^(BOOL finished) {
                         [[self loadingProgressView] setProgress:0.f animated:NO];
                     }];
}


#pragma mark - LOAD A WEBVIEW PROGRESS


- (void)addProgressObserver:(WKWebView *)aWebView
{
    [aWebView addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)removeProgressObserver:(WKWebView *)aWebView
{
    [aWebView removeObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
}


#pragma mark - OBSERVE PROGRESS


- (void)observeValueForKeyPath:(NSString *)aKeyPath ofObject:(id)aObject change:(NSDictionary *)aChange context:(void *)aContext
{
    if ([aKeyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))])
    {
        NSNumber *sNewNumber = [aChange objectForKey:NSKeyValueChangeNewKey];
        
        [[self loadingProgressView] setProgress:[sNewNumber floatValue] animated:YES];
    }
}

@end
