//
//  CMTabOverViewModel.h
//  CustomMultipleWebViewExample
//
//  Created by tigi on 14/02/2019.
//  Copyright © 2019 tigi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
#import "CMTabOverViewCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CMTabOverViewDelegate <NSObject>

- (void)closeEachWebInTabOverView:(WKWebView *)aCloseWebView;
- (void)actionChangeActiveWebView:(WKWebView *)aActiveWebView;

@end

@interface CMTabOverViewModel : NSObject

@property(nonatomic, weak) id<CMTabOverViewDelegate> delegate;

- (instancetype)initWithWKWebView:(WKWebView *)aWebView NS_DESIGNATED_INITIALIZER;

+ (Class)cellClass;
- (UICollectionViewCell *)collectionView:(UICollectionView *)aCollectionView cellForItemAtIndexPath:(NSIndexPath *)aIndexPath;

@end

NS_ASSUME_NONNULL_END
