//
//  CMTabOverViewModel.h
//  CustomMultipleWebViewExample
//
//  Created by tigi on 14/02/2019.
//  Copyright © 2019 tigi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>


NS_ASSUME_NONNULL_BEGIN

@protocol CMTabOverViewActionDelegate <NSObject>

- (void)actionCloseWebView:(UIButton *)aSender;
- (void)actionChangeActiveWebView:(UIButton *)aSender;

@end


@interface CMTabOverViewModel : NSObject

- (instancetype)initWithWKWebView:(WKWebView *)aWebView actionTarger:(nullable id<CMTabOverViewActionDelegate>)aTarget NS_DESIGNATED_INITIALIZER;

+ (Class)cellClass;
- (UICollectionViewCell *)collectionView:(UICollectionView *)aCollectionView cellForItemAtIndexPath:(NSIndexPath *)aIndexPath;

@end

NS_ASSUME_NONNULL_END
