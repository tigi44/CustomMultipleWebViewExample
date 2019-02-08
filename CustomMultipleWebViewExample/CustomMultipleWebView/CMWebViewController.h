//
//  CMWebViewController.h
//  CustomMultipleWebViewExample
//
//  Created by tigi on 01/02/2019.
//  Copyright © 2019 tigi. All rights reserved.
//

#import "CMBaseWKWebViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, CMWebViewPageType)
{
    WebViewSinglePageType = 0,
    WebViewMultiplePageType
};

@interface CMWebViewController : CMBaseWKWebViewController

@property(nonatomic, assign) CMWebViewPageType pageType;

@end

NS_ASSUME_NONNULL_END
