//
//  CMWebViewController+TabOverView.m
//  CustomMultipleWebViewExample
//
//  Created by tigi on 13/02/2019.
//  Copyright © 2019 tigi. All rights reserved.
//

#import "CMWebViewController+TabOverView.h"


static NSInteger kItemCountOnRowOfCollectionView = 2;
static CGFloat kTabOverViewButtonMarginRight = 30;

@interface CMWebViewController()

@property(nonatomic, readwrite) NSMutableArray<WKWebView *> *webViews;
@property(nonatomic, readwrite) WKWebView                   *activeWebView;

@property(nonatomic, readwrite) UIButton *tabOverViewButton;
@property(nonatomic, readwrite) UICollectionView *tabOverViewCollectionView;

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
    CGFloat sTabOverViewButtonPositionX = CGRectGetMinX(self.topView.closeButton.frame) - kTabOverViewButtonMarginRight;
    CGFloat sTabOverViewButtonPositionY = CGRectGetMinY(self.topView.closeButton.frame);
    
    self.tabOverViewButton = [[UIButton alloc] initWithFrame:CGRectMake(sTabOverViewButtonPositionX, sTabOverViewButtonPositionY, CGRectGetWidth(self.topView.closeButton.frame), CGRectGetHeight(self.topView.closeButton.frame))];
    [self.tabOverViewButton setBackgroundColor:[UIColor whiteColor]];
    [self.tabOverViewButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.tabOverViewButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [[self.tabOverViewButton titleLabel] setAdjustsFontSizeToFitWidth:YES];
    [self.tabOverViewButton.layer setBorderWidth:1.f];
    [self.tabOverViewButton.layer setBorderColor:[UIColor lightGrayColor].CGColor];

    [self.tabOverViewButton addTarget:self action:@selector(actionTabOverViewButton:) forControlEvents:UIControlEventTouchUpInside];

    [self.topView addSubview:self.tabOverViewButton];
}

- (void)setupTapOverViewCollectionView
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
                      duration:1.0f
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    animations:^{ [self.view addSubview:sWeakCollectionView]; }
                    completion:nil];
}

- (void)hideTabOverViewCollectionView
{
    [self.topView.urlTextField setText:self.activeWebView.URL.absoluteString];
    
    __weak UICollectionView *sWeakCollectionView = self.tabOverViewCollectionView;
    [UIView transitionWithView:self.view
                      duration:1.0f
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
    WKWebView *sCloseWebView = [self.webViews objectAtIndex:aSender.tag];
    
    [self closeEachWebInTabOverView:sCloseWebView];
}

- (void)actionChangeActiveWebView:(UIButton *)aSender
{
    WKWebView *sActiveWebView = [self.webViews objectAtIndex:aSender.tag];
    
    [self changeActiveWebView:sActiveWebView];
}


#pragma mark - CMTabOverViewDelegate


- (void)closeEachWebInTabOverView:(WKWebView *)aCloseWebView
{
    if ([self.webViews count] > 1)
    {
        [aCloseWebView removeFromSuperview];
        [self.webViews removeObject:aCloseWebView];
        
        if (aCloseWebView == self.activeWebView)
        {
            self.activeWebView = [self.webViews lastObject];
        }
        
        [self.tabOverViewCollectionView reloadData];
        
        aCloseWebView = nil;
    }
    
    [self updateTabOverViewButton];
}

- (void)changeActiveWebView:(WKWebView *)aActiveWebView
{
    BOOL sIsFrontOfActive = NO;
    self.activeWebView = aActiveWebView;
    
    for (WKWebView *sWebView in self.webViews)
    {
        [sWebView setHidden:sIsFrontOfActive];
        
        if (!sIsFrontOfActive && sWebView == self.activeWebView)
        {
            sIsFrontOfActive = YES;
        }
    }
    
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
