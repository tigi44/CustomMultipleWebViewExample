//
//  CMTabOverViewModel.m
//  CustomMultipleWebViewExample
//
//  Created by tigi on 14/02/2019.
//  Copyright © 2019 tigi. All rights reserved.
//

#import "CMTabOverViewModel.h"
#import "CMTabOverViewCollectionViewCell.h"

@implementation CMTabOverViewModel
{
    WKWebView *mWebView;
    id<CMTabOverViewActionDelegate> mTarget;
}

- (instancetype)initWithWKWebView:(WKWebView *)aWebView actionTarger:(nullable id<CMTabOverViewActionDelegate>)aTarget
{
    self = [super init];
    if (self) {
        mWebView = aWebView;
        mTarget = aTarget;
    }
    return self;
}

- (instancetype)init
{
    return [self initWithWKWebView:[WKWebView new] actionTarger:nil];
}


#pragma mark - UICollectionViewDataSource


- (UICollectionViewCell *)collectionView:(UICollectionView *)aCollectionView cellForItemAtIndexPath:(NSIndexPath *)aIndexPath
{
    UICollectionViewCell *sCollectionViewCell = [aCollectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([[self class] cellClass]) forIndexPath:aIndexPath];
    
    [self bindViewModelToCell:(CMTabOverViewCollectionViewCell *)sCollectionViewCell];
    
    return sCollectionViewCell;
}

+ (Class)cellClass
{
    return [CMTabOverViewCollectionViewCell class];
}


#pragma mark - bindToCell


- (void)bindViewModelToCell:(CMTabOverViewCollectionViewCell *)aCell
{
    BOOL sHiddenWebView = mWebView.hidden;
    
    [mWebView setHidden:NO];
    UIGraphicsBeginImageContext(mWebView.bounds.size);
    [mWebView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *sWebViewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [mWebView setHidden:sHiddenWebView];
    [[aCell webImageView] setImage:sWebViewImage];
    
    [mWebView evaluateJavaScript:@"document.title"
               completionHandler:^(id _Nullable result, NSError * _Nullable error) {
                   [[aCell titleLabel] setText:result];
               }
     ];
    
    if (mTarget)
    {
        [[aCell boundButton] setTag:mWebView.tag];
        [[aCell closeButton] setTag:mWebView.tag];
        [[aCell boundButton] addTarget:mTarget action:@selector(actionChangeActiveWebView:) forControlEvents:UIControlEventTouchUpInside];
        [[aCell closeButton] addTarget:mTarget action:@selector(actionCloseWebView:) forControlEvents:UIControlEventTouchUpInside];
    }
}

@end
