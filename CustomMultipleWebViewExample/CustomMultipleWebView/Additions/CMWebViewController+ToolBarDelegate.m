//
//  CMWebViewController+ToolBarDelegate.m
//  CustomMultipleWebViewExample
//
//  Created by tigi on 11/03/2019.
//  Copyright © 2019 tigi. All rights reserved.
//

#import "CMWebViewController+ToolBarDelegate.h"

@interface CMWebViewController()

- (void)actionTabOverViewButton;

@end

@implementation CMWebViewController (ToolBarDelegate)


#pragma mark - CMRefreshButtonDelegate


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


#pragma mark - CMBottomToolBarDelegate


- (void)bottomToolBar:(nonnull CMBottomToolBar *)aToolBar tappedIndex:(CMBottomToolBarButtonItemIndex)aIndex
{
    switch (aIndex) {
        case CMBottomToolBarButtonItemBack:
            [self.webView goBack];
            break;
        case CMBottomToolBarButtonItemForward:
            [self.webView goForward];
            break;
        case CMBottomToolBarButtonItemReload:
            [self.webView reload];
            break;
        case CMBottomToolBarButtonItemTab:
            [self actionTabOverViewButton];
            break;
    }
}

@end
