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
static CGFloat kTabOverViewButtonMarginRight = 30;

@interface CMWebViewController()

@property(nonatomic, readwrite) NSMutableArray<WKWebView *> *webViews;

@property(nonatomic, readwrite) UIButton *tabOverViewButton;
@property(nonatomic, readwrite) UICollectionView *tabOverViewCollectionView;

- (void)closeWebView:(WKWebView *)aClosingWebView;
- (void)showActiveWebView;

@end

@implementation CMWebViewController (TabOverView)


#pragma mark -PUBLIC


- (void)setupTabOverView
{
    [self setupTabOverViewButton];
    [self setupTapOverViewCollectionView];
}

- (void)setupTabOverViewButton
{
    if (self.tabOverViewButton == nil)
    {
        CGFloat sTabOverViewButtonPositionX = CGRectGetMinX(self.topView.closeButton.frame) - kTabOverViewButtonMarginRight;
        CGFloat sTabOverViewButtonPositionY = CGRectGetMinY(self.topView.closeButton.frame);
        
        self.tabOverViewButton = [[UIButton alloc] initWithFrame:CGRectMake(sTabOverViewButtonPositionX, sTabOverViewButtonPositionY, CGRectGetWidth(self.topView.closeButton.frame), CGRectGetHeight(self.topView.closeButton.frame))];
        [self.tabOverViewButton setBackgroundColor:[UIColor whiteColor]];
        [self.tabOverViewButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.tabOverViewButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
        [[self.tabOverViewButton titleLabel] setFont:[UIFont systemFontOfSize:12.f]];
        [[self.tabOverViewButton titleLabel] setAdjustsFontSizeToFitWidth:YES];
        [self.tabOverViewButton.layer setBorderWidth:1.f];
        [self.tabOverViewButton.layer setBorderColor:[UIColor lightGrayColor].CGColor];

        [self.tabOverViewButton addTarget:self action:@selector(actionTabOverViewButton:) forControlEvents:UIControlEventTouchUpInside];

        [self.topView addSubview:self.tabOverViewButton];
    }
}

- (void)setupTapOverViewCollectionView
{
    if (self.tabOverViewCollectionView == nil)
    {
        self.tabOverViewCollectionView = [[UICollectionView alloc] initWithFrame:self.webView.frame collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
        
        CGFloat sItemSize = self.tabOverViewCollectionView.frame.size.width / kItemCountOnRowOfCollectionView;
        UICollectionViewFlowLayout *sLayout = (UICollectionViewFlowLayout *)[self.tabOverViewCollectionView collectionViewLayout];
        [sLayout setItemSize:CGSizeMake(sItemSize, sItemSize)];
        [sLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        [sLayout setFooterReferenceSize:CGSizeZero];
        [sLayout setHeaderReferenceSize:CGSizeZero];
        [sLayout setMinimumLineSpacing:0.0f];
        [sLayout setMinimumInteritemSpacing:0.0f];
        
        [self.tabOverViewCollectionView setBackgroundColor:[UIColor whiteColor]];
        [self.tabOverViewCollectionView registerClass:[CMTabOverViewModel cellClass] forCellWithReuseIdentifier:NSStringFromClass([CMTabOverViewModel cellClass])];
        [self.tabOverViewCollectionView setDataSource:self];
        [self.tabOverViewCollectionView setDelegate:self];
    }
}

- (void)updateTabOverViewButton
{
    NSInteger sCountOfTabs = [self.webViews count];
    [self.tabOverViewButton setTitle:[@(sCountOfTabs) stringValue] forState:UIControlStateNormal];
}


#pragma mark - PRIVATE


- (void)showTabOverViewCollectionView
{
    [self.topView.urlTextField setText:nil];
    [self.tabOverViewCollectionView reloadData];
    
    __weak UICollectionView *sWeakCollectionView = self.tabOverViewCollectionView;
    [UIView transitionWithView:self.view
                      duration:kAnimateTabOverCollectionViewDuration
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    animations:^{ [self.view addSubview:sWeakCollectionView]; }
                    completion:nil];
}

- (void)hideTabOverViewCollectionView
{
    [self showActiveWebView];
    [self.topView.urlTextField setText:self.webView.URL.absoluteString];
    
    __weak UICollectionView *sWeakCollectionView = self.tabOverViewCollectionView;
    [UIView transitionWithView:self.view
                      duration:kAnimateTabOverCollectionViewDuration
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{ [sWeakCollectionView removeFromSuperview]; }
                    completion:nil];
}


#pragma mark - ACTION


- (void)actionTabOverViewButton:(id)aSender
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

- (void)actionCloseWebView:(UIButton *)aSender
{
    WKWebView *sClosingWebView = [self.webViews objectAtIndex:aSender.tag];
    
    [self closeEachWebInTabOverView:sClosingWebView];
}

- (void)actionChangeActiveWebView:(UIButton *)aSender
{
    WKWebView *sActiveWebView = [self.webViews objectAtIndex:aSender.tag];
    
    [self changeActiveWebView:sActiveWebView];
}


#pragma mark - CMTabOverViewDelegate


- (void)closeEachWebInTabOverView:(WKWebView *)aClosingWebView
{
    [self closeWebView:aClosingWebView];
    
    [self.tabOverViewCollectionView reloadData];
    [self updateTabOverViewButton];
}

- (void)changeActiveWebView:(WKWebView *)aActiveWebView
{
    self.webView = aActiveWebView;
    
    [self hideTabOverViewCollectionView];
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
    
    CMTabOverViewModel *sViewModel = [[CMTabOverViewModel alloc] initWithWKWebView:sWebView];
    [sViewModel setDelegate:self];
    
    return [sViewModel collectionView:aCollectionView cellForItemAtIndexPath:aIndexPath];
}

@end
