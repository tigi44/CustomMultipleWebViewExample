//
//  CMWebViewController.h
//  CustomMultipleWebViewExample
//
//  Created by tigi on 01/02/2019.
//  Copyright © 2019 tigi. All rights reserved.
//

#import "CMBaseWKWebViewController.h"
#import "CMTopToolBar.h"
#import "CMBottomToolBar.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, CMWebViewPageType)
{
    WebViewSinglePageType = 0,
    WebViewMultiplePageType
};

@interface CMWebViewController : CMBaseWKWebViewController

@property(nonatomic, readonly) CMTopToolBar *topToolBar;
@property(nonatomic, readonly) CMBottomToolBar *bottomToolBar;

- (instancetype)initWithURL:(NSURL *)aURL pageType:(CMWebViewPageType)aPageType NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
