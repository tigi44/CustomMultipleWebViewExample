//
//  CMTabOverViewCollectionViewCell.m
//  CustomMultipleWebViewExample
//
//  Created by tigi on 13/02/2019.
//  Copyright © 2019 tigi. All rights reserved.
//

#import "CMTabOverViewCollectionViewCell.h"


static CGFloat kBoundViewMargin = 20;

@implementation CMTabOverViewCollectionViewCell

- (instancetype)initWithFrame:(CGRect)aFrame
{
    self = [super initWithFrame:aFrame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setClipsToBounds:YES];
        
        [self setupBoundButton];
        [self setupWebImageView];
        [self setupTitleLabel];
        [self setupCloseButton];
    }
    return self;
}


#pragma mark - override


- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (CGSize)sizeThatFits:(CGSize)aSize
{
    [_titleLabel sizeToFit];
    [_boundButton setFrame:CGRectMake(kBoundViewMargin, kBoundViewMargin, aSize.width - kBoundViewMargin * 2, aSize.height - kBoundViewMargin * 2)];
    
    CGSize sBoundViewSize = CGSizeMake(CGRectGetWidth(_boundButton.frame), CGRectGetHeight(_boundButton.frame));
    CGSize sTitleLabelSize = _titleLabel.frame.size;
    CGSize sCloseButtonSize = CGSizeMake(sTitleLabelSize.height, sTitleLabelSize.height);
    
    [_webImageView setFrame:CGRectMake(0, 0, sBoundViewSize.width, sBoundViewSize.height)];
    
    [_closeButton setFrame:CGRectMake(0, 0, sCloseButtonSize.width, sCloseButtonSize.height)];
    
    [_titleLabel setFrame:CGRectMake(sCloseButtonSize.width, 0, sBoundViewSize.width - sCloseButtonSize.width, sTitleLabelSize.height)];
    
    return aSize;
}


#pragma mark - setup


- (void)setupBoundButton
{
    _boundButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_boundButton setBackgroundColor:[UIColor grayColor]];
    [_boundButton.layer setBorderWidth:1.0f];
    [_boundButton.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    
    [self.contentView addSubview:_boundButton];
}

- (void)setupWebImageView
{
    _webImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [_webImageView setClipsToBounds:YES];
    
    [_boundButton addSubview:_webImageView];
}

- (void)setupTitleLabel
{
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [_titleLabel setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]];
    [_titleLabel setFont:[UIFont systemFontOfSize:15.f]];
    [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    [_boundButton addSubview:_titleLabel];
}

- (void)setupCloseButton
{
    _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_closeButton setImage:[UIImage imageNamed:@"closeButtonImage"] forState:UIControlStateNormal];
    [_closeButton setBackgroundColor:[UIColor colorWithRed:255 green:255 blue:255 alpha:0.1]];
    
    [_boundButton addSubview:_closeButton];
}

@end
