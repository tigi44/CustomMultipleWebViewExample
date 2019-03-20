//
//  CMWebViewController+TabOverView.m
//  CustomMultipleWebViewExample
//
//  Created by tigi on 13/02/2019.
//  Copyright © 2019 tigi. All rights reserved.
//

#import "CMWebViewController+TabOverView.h"


static CGFloat kAnimateTabOverCollectionViewDuration = 0.5f;
static CGFloat kItemSize = 200.f;
//static NSInteger kItemCountOnRowOfCollectionView = 2;

@interface CMWebViewController()

@property(nonatomic, readwrite) CMTopToolBar *topToolBar;
@property(nonatomic, readwrite) CMBottomToolBar *bottomToolBar;
@property(nonatomic, readwrite) NSMutableArray<CMProgressWebView *> *webViews;

@property(nonatomic, readwrite) UICollectionView *tabOverViewCollectionView;

- (BOOL)closeWebView:(CMProgressWebView *)aClosingWebView;
- (void)showActiveWebView:(CMProgressWebView *)aActiveWebView;

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
    [sLayout setItemSize:CGSizeMake(kItemSize, kItemSize)];
    
    [self.tabOverViewCollectionView setBackgroundColor:[UIColor whiteColor]];
    [self.tabOverViewCollectionView registerClass:[CMTabOverViewModel cellClass] forCellWithReuseIdentifier:NSStringFromClass([CMTabOverViewModel cellClass])];
    [self.tabOverViewCollectionView setDataSource:self];
    [self.tabOverViewCollectionView setDelegate:self];
    [self.tabOverViewCollectionView setHidden:YES];
    
    [self.view addSubview:self.tabOverViewCollectionView];
    
    self.tabOverViewCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.tabOverViewCollectionView.leadingAnchor constraintEqualToAnchor:self.webView.leadingAnchor].active = YES;
    [self.tabOverViewCollectionView.trailingAnchor constraintEqualToAnchor:self.webView.trailingAnchor].active = YES;
    [self.tabOverViewCollectionView.topAnchor constraintEqualToAnchor:self.webView.topAnchor].active = YES;
    [self.tabOverViewCollectionView.bottomAnchor constraintEqualToAnchor:self.webView.bottomAnchor].active = YES;
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

- (void)toggleTabOverView
{
    if (!self.tabOverViewCollectionView.isHidden)
    {
        [self hideTabOverViewCollectionView];
    }
    else
    {
        [self showTabOverViewCollectionView];
    }
}

#pragma mark - PRIVATE


- (void)showTabOverViewCollectionView
{
    [self.webView setHidden:YES];
    [self.topToolBar.urlTextField setText:nil];
    [self.tabOverViewCollectionView reloadData];
    [[self bottomToolBar] setToolBarType:CMBottomToolBarTypeInTab];
    
    __weak UICollectionView *sWeakCollectionView = self.tabOverViewCollectionView;
    [UIView transitionWithView:self.view
                      duration:kAnimateTabOverCollectionViewDuration
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    animations:^{
                        [sWeakCollectionView setHidden:NO];
                    }
                    completion:^(BOOL finished) {
                        [sWeakCollectionView setHidden:NO];
                    }];
}

- (void)hideTabOverViewCollectionView
{
    [self.webView setHidden:NO];
    [self.topToolBar.urlTextField setText:self.webView.URL.absoluteString];
    [[self bottomToolBar] setToolBarType:CMBottomToolBarTypeNormal];
    
    __weak UICollectionView *sWeakCollectionView = self.tabOverViewCollectionView;
    [UIView transitionWithView:self.view
                      duration:kAnimateTabOverCollectionViewDuration
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        [sWeakCollectionView setHidden:YES];
                    }
                    completion:^(BOOL finished) {
                        [sWeakCollectionView setHidden:YES];
                    }];
}

- (void)closeEachWebInTabOverView:(CMProgressWebView *)aClosingWebView
{
    NSInteger sIndexOfWebView = [self.webViews indexOfObject:aClosingWebView];
    NSIndexPath *sIndexPath = [NSIndexPath indexPathForRow:sIndexOfWebView inSection:0];
    
    BOOL sIsCloseSuccess = [self closeWebView:aClosingWebView];
    
    if (sIsCloseSuccess)
    {
        [self.tabOverViewCollectionView deleteItemsAtIndexPaths:@[sIndexPath]];
    }
}

- (void)changeActiveWebView:(CMProgressWebView *)aActiveWebView
{
    [self showActiveWebView:aActiveWebView];
    
    [self hideTabOverViewCollectionView];
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
