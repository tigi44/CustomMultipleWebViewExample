//
//  CMWebViewController+CMRefreshButtonDelegate.m
//  CustomMultipleWebViewExample
//
//  Created by tigi on 11/03/2019.
//  Copyright © 2019 tigi. All rights reserved.
//

#import "CMWebViewController+CMRefreshButtonDelegate.h"

@implementation CMWebViewController (CMRefreshButtonDelegate)

- (void)refreshButton:(CMRefreshButton *)aRefreshButton refreshState:(CMRefreshState)aRefreshState
{
    switch (aRefreshState) {
        case CMRefreshReadyState:
            [self.webView reload];
            break;
        case CMRefreshRefreshingState:
            [self.webView stopLoading];
            break;
    }
}

@end
