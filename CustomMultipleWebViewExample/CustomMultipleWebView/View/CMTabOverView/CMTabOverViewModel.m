//
//  CMTabOverViewModel.m
//  CustomMultipleWebViewExample
//
//  Created by tigi on 14/02/2019.
//  Copyright © 2019 tigi. All rights reserved.
//

#import "CMTabOverViewModel.h"

@implementation CMTabOverViewModel
{
    WKWebView *mWebView;
}

- (instancetype)initWithWKWebView:(WKWebView *)aWebView
{
    self = [super init];
    if (self) {
        mWebView = aWebView;
    }
    return self;
}

- (instancetype)init
{
    return [self initWithWKWebView:[WKWebView new]];
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
    [aCell webImageView].transform = CGAffineTransformMakeScale(0.5, 0.5);
    [aCell webImageView].transform = CGAffineTransformTranslate([aCell webImageView].transform, -1 * CGRectGetWidth([aCell webImageView].frame), -1 * CGRectGetHeight([aCell webImageView].frame));
    
    [mWebView evaluateJavaScript:@"document.title"
               completionHandler:^(id _Nullable result, NSError * _Nullable error) {
                   [[aCell titleLabel] setText:result];
                   [aCell sizeToFit];
               }
     ];
    
    if (_delegate)
    {
        [[aCell boundButton] setTag:mWebView.tag];
        [[aCell closeButton] setTag:mWebView.tag];
        [[aCell boundButton] addTarget:_delegate action:@selector(actionChangeActiveWebView:) forControlEvents:UIControlEventTouchUpInside];
        [[aCell closeButton] addTarget:_delegate action:@selector(actionCloseWebView:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [aCell sizeToFit];
}

@end
