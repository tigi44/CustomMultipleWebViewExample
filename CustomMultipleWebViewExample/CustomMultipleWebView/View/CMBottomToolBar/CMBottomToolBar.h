//
//  CMBottomToolBar.h
//  CustomMultipleWebViewExample
//
//  Created by tigi on 19/03/2019.
//  Copyright © 2019 tigi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, CMBottomToolBarType)
{
    CMBottomToolBarTypeNormal = 0,
    CMBottomToolBarTypeInTab,
    CMBottomToolBarTypeNoneTab
};

typedef NS_ENUM(NSInteger, CMBottomToolBarButtonItemIndex)
{
    CMBottomToolBarButtonItemBack = 0,
    CMBottomToolBarButtonItemForward,
    CMBottomToolBarButtonItemReload,
    CMBottomToolBarButtonItemTab,
    CMBottomToolBarButtonItemAdd
};


@protocol CMBottomToolBarDelegate;

@interface CMBottomToolBar : UIToolbar

@property(nonatomic, weak) id<CMBottomToolBarDelegate> toolBarDelegate;
@property(nonatomic, assign) CMBottomToolBarType toolBarType;

- (UIBarButtonItem *)barButtonItemAtIndex:(CMBottomToolBarButtonItemIndex)aIndex;

@end


@protocol CMBottomToolBarDelegate

- (void)bottomToolBar:(CMBottomToolBar *)aToolBar tappedIndex:(CMBottomToolBarButtonItemIndex)aIndex;

@end

NS_ASSUME_NONNULL_END
