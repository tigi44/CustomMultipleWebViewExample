//
//  CMWebViewController+TabOverView.h
//  CustomMultipleWebViewExample
//
//  Created by tigi on 13/02/2019.
//  Copyright © 2019 tigi. All rights reserved.
//

#import "CMWebViewController.h"
#import "CMTabOverViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CMWebViewController (TabOverView) <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CMTabOverViewActionDelegate>

- (void)setupTapOverViewCollectionView;
- (void)updateCountOnTabOverViewButton;
- (void)layoutTapOverViewCollectionView;

@end

NS_ASSUME_NONNULL_END
