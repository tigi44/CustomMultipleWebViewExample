//
//  CMTabOverViewCollectionViewCell.h
//  CustomMultipleWebViewExample
//
//  Created by tigi on 13/02/2019.
//  Copyright © 2019 tigi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CMTabOverViewCollectionViewCell : UICollectionViewCell

@property(nonatomic, readonly) UIButton *boundButton;
@property(nonatomic, readonly) UIButton *closeButton;
@property(nonatomic, readonly) UILabel *titleLabel;
@property(nonatomic, readonly) UIImageView *webImageView;

@end

NS_ASSUME_NONNULL_END
