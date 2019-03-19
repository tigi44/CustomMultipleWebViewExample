//
//  CMWebViewController+TabOverView.m
//  CustomMultipleWebViewExample
//
//  Created by tigi on 13/02/2019.
//  Copyright © 2019 tigi. All rights reserved.
//

#import "CMWebViewController+TabOverView.h"


static CGFloat kAnimateTabOverCollectionViewDuration = 0.5f;
static NSInteger kItemCountOnRowOfCollectionView = 2;

@interface CMWebViewController()

@property(nonatomic, readwrite) CMTopView *topView;
@property(nonatomic, readwrite) CMBottomToolBar *bottomToolBar;
@property(nonatomic, readwrite) NSMutableArray<CMProgressWebView *> *webViews;

@property(nonatomic, readwrite) UICollectionView *tabOverViewCollectionView;

- (BOOL)closeWebView:(CMProgressWebView *)aClosingWebView;
- (void)showActiveWebView;

@end

@implementation CMWebViewController (TabOverView)


#pragma mark -PUBLIC


- (void)setupTapOverViewCollectionView
{
    self.tabOverViewCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    
    UICollectionViewFlowLayout *sLayout = (UICollectionViewFlowLayout *)[self.tabOverViewCollectionView collectionViewLayout];
    [sLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [sLayout setFooterReferenceSize:CGSizeZero];
    [sLayout setHeaderReferenceSize:CGSizeZero];
    [sLayout setMinimumLineSpacing:0.0f];
    [sLayout setMinimumInteritemSpacing:0.0f];
    
    [self.tabOverViewCollectionView setBackgroundColor:[UIColor whiteColor]];
    [self.tabOverViewCollectionView registerClass:[CMTabOverViewModel cellClass] forCellWithReuseIdentifier:NSStringFromClass([CMTabOverViewModel cellClass])];
    [self.tabOverViewCollectionView setDataSource:self];
    [self.tabOverViewCollectionView setDelegate:self];
    [self.tabOverViewCollectionView setHidden:YES];
    
    [self.topView.tabOverViewButton addTarget:self action:@selector(actionTabOverViewButton) forControlEvents:UIControlEventTouchUpInside];
}

- (void)updateCountOnTabOverViewButton
{
    NSInteger sCountOfTabs = [self.webViews count];
    [self.topView.tabOverViewButton setTitle:[@(sCountOfTabs) stringValue] forState:UIControlStateNormal];
}

- (void)layoutTapOverViewCollectionView
{
    [self.tabOverViewCollectionView setFrame:self.webView.frame];
    
    CGFloat sItemSize = self.tabOverViewCollectionView.frame.size.width / kItemCountOnRowOfCollectionView;
    UICollectionViewFlowLayout *sLayout = (UICollectionViewFlowLayout *)[self.tabOverViewCollectionView collectionViewLayout];
    [sLayout setItemSize:CGSizeMake(sItemSize, sItemSize)];
}

- (void)createNewWebViewInTabOverView
{
    [self webView:self.webView createWebViewWithConfiguration:[self.webView configuration] forNavigationAction:[WKNavigationAction new] windowFeatures:[WKWindowFeatures new]];
    [self changeActiveWebView:self.webView];
}

- (BOOL)isShowingTabOverView
{
    BOOL sResult = NO;
    
    sResult = ([self.tabOverViewCollectionView superview] && ![self.tabOverViewCollectionView isHidden])? YES : NO;
    
    return sResult;
}

#pragma mark - PRIVATE


- (void)showTabOverViewCollectionView
{
    [self.topView.urlTextField setText:nil];
    [self.tabOverViewCollectionView reloadData];
    [[self bottomToolBar] setToolBarType:CMBottomToolBarTypeTab];
    
    __weak UICollectionView *sWeakCollectionView = self.tabOverViewCollectionView;
    [UIView transitionWithView:self.view
                      duration:kAnimateTabOverCollectionViewDuration
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    animations:^{
                        [sWeakCollectionView setHidden:NO];
                        [self.view addSubview:sWeakCollectionView];
                    }
                    completion:nil];
}

- (void)hideTabOverViewCollectionView
{
    [self showActiveWebView];
    [self.topView.urlTextField setText:self.webView.URL.absoluteString];
    [[self bottomToolBar] setToolBarType:CMBottomToolBarTypeNormal];
    
    __weak UICollectionView *sWeakCollectionView = self.tabOverViewCollectionView;
    [UIView transitionWithView:self.view
                      duration:kAnimateTabOverCollectionViewDuration
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        [sWeakCollectionView removeFromSuperview];
                    }
                    completion:^(BOOL finished) {
                        [sWeakCollectionView setHidden:YES];
                    }];
}

- (void)closeEachWebInTabOverView:(CMProgressWebView *)aClosingWebView
{
    NSInteger sIndexOfWebView = [self.webViews indexOfObject:aClosingWebView];
    NSIndexPath *sIndexPath = [NSIndexPath indexPathForRow:sIndexOfWebView inSection:0];
    
    [self.tabOverViewCollectionView performBatchUpdates:^{
        BOOL sIsCloseSuccess = [self closeWebView:aClosingWebView];
        
        if (sIsCloseSuccess)
        {
            [self.tabOverViewCollectionView deleteItemsAtIndexPaths:@[sIndexPath]];
            [self updateCountOnTabOverViewButton];
        }
    } completion:^(BOOL finished) {
        [self.tabOverViewCollectionView reloadData];
    }];
}

- (void)changeActiveWebView:(CMProgressWebView *)aActiveWebView
{
    self.webView = aActiveWebView;
    
    [self hideTabOverViewCollectionView];
}


#pragma mark - ACTION


- (void)actionTabOverViewButton
{
    BOOL sContainedSubView = NO;
    
    for (UIView *sSubView in self.view.subviews)
    {
        if (sSubView == self.tabOverViewCollectionView)
        {
            sContainedSubView = YES;
            break;
        }
    }
    
    if (sContainedSubView)
    {
        [self hideTabOverViewCollectionView];
    }
    else
    {
        [self showTabOverViewCollectionView];
    }
}


#pragma mark - CMTabOverViewActionDelegate


- (void)actionCloseWebView:(UIButton *)aSender
{
    CMProgressWebView *sClosingWebView = [self.webViews objectAtIndex:aSender.tag];
    
    [self closeEachWebInTabOverView:sClosingWebView];
}

- (void)actionChangeActiveWebView:(UIButton *)aSender
{
    CMProgressWebView *sActiveWebView = [self.webViews objectAtIndex:aSender.tag];
    
    [self changeActiveWebView:sActiveWebView];
}


#pragma mark - UICollectionViewDataSource


- (NSInteger)collectionView:(UICollectionView *)aCollectionView numberOfItemsInSection:(NSInteger)aSection
{
    return [self.webViews count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)aCollectionView cellForItemAtIndexPath:(NSIndexPath *)aIndexPath
{
    WKWebView *sWebView = [self.webViews objectAtIndex:[aIndexPath row]];
    [sWebView setTag:[aIndexPath row]];
    
    CMTabOverViewModel *sViewModel = [[CMTabOverViewModel alloc] initWithWKWebView:sWebView actionTarger:self];
    
    return [sViewModel collectionView:aCollectionView cellForItemAtIndexPath:aIndexPath];
}

@end
