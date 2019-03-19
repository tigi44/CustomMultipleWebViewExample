//
//  CMTopView.h
//  CustomMultipleWebViewExample
//
//  Created by tigi on 07/02/2019.
//  Copyright © 2019 tigi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMRefreshButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface CMTopView : UIView

@property(nonatomic, readonly) UITextField *urlTextField;
@property(nonatomic, readonly) CMRefreshButton *refreshButton;
@property(nonatomic, readonly) UIButton *tabOverViewButton;
@property(nonatomic, readonly) UIButton *closeButton;
@property(nonatomic, readonly) UIView *borderBottomLineView;

- (instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
