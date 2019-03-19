//
//  CMRefreshButton.h
//  CustomMultipleWebViewExample
//
//  Created by tigi on 08/03/2019.
//  Copyright © 2019 tigi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, CMRefreshState)
{
    CMRefreshReadyState = 0,
    CMRefreshRefreshingState
};

@protocol CMRefreshButtonDelegate;

@interface CMRefreshButton : UIButton

@property(nonatomic, weak) id<CMRefreshButtonDelegate> delegate;
@property(nonatomic, readwrite) CMRefreshState refreshState;

@end

@protocol CMRefreshButtonDelegate

- (void)refreshButton:(CMRefreshButton *)aRefreshButton refreshState:(CMRefreshState)aRefreshState;

@end

NS_ASSUME_NONNULL_END
