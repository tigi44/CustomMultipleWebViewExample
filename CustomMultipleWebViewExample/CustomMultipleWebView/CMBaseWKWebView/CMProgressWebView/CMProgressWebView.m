//
//  CMProgressWebView.m
//  CustomMultipleWebViewExample
//
//  Created by tigi on 28/02/2019.
//  Copyright © 2019 tigi. All rights reserved.
//

#import "CMProgressWebView.h"
#import "CMWKProcessPoolHandler.h"

@implementation CMProgressWebView

- (instancetype)initWithFrame:(CGRect)aFrame configuration:(nullable WKWebViewConfiguration *)aConfiguration
{
    self = [super initWithFrame:aFrame configuration:[[self class] webViewConfiguration:aConfiguration]];
    if (self) {
        [self setAllowsBackForwardNavigationGestures:YES];
        
        [self setupProgressView];
        [self addProgressObserver];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    return [self initWithFrame:CGRectZero configuration:nil];
}

- (instancetype)initWithFrame:(CGRect)aFrame
{
    return [self initWithFrame:aFrame configuration:nil];
}

- (instancetype)init
{
    return [self initWithFrame:CGRectZero configuration:nil];
}

- (void)dealloc
{
    [self removeProgressObserver];
}

- (void)layoutSubviews
{
    [_loadingProgressView setFrame:CGRectMake(0, 0, self.frame.size.width, 0)];
}

- (CGSize)sizeThatFits:(CGSize)aSize
{
    [_loadingProgressView setFrame:CGRectMake(0, 0, aSize.width, 0)];
    
    return aSize;
}

+ (WKWebViewConfiguration *)webViewConfiguration:(WKWebViewConfiguration *)aConfiguration
{
    WKWebViewConfiguration *sResult;
    
    if (aConfiguration)
    {
        sResult = aConfiguration;
    }
    else
    {
        sResult = [[WKWebViewConfiguration alloc] init];
        sResult.processPool = [CMWKProcessPoolHandler pool];
        sResult.preferences.javaScriptCanOpenWindowsAutomatically = YES;
    }
    
    return sResult;
}


#pragma mark - SETUP


- (void)setupProgressView
{
    _loadingProgressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    [_loadingProgressView setTrackTintColor:[UIColor clearColor]];
    [_loadingProgressView setTintColor:[UIColor redColor]];
    [_loadingProgressView setAlpha:0.f];
    [_loadingProgressView setClipsToBounds:YES];
    [_loadingProgressView.layer setCornerRadius:2.f];
    
    [self addSubview:_loadingProgressView];
}


#pragma mark - SHOW/HIDE LOADING PROGRESS


- (void)showLoadingProgressView
{
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


- (void)addProgressObserver
{
    [self addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)removeProgressObserver
{
    [self removeObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
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
