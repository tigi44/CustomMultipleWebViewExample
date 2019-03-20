//
//  CMTabOverViewCollectionViewCell.m
//  CustomMultipleWebViewExample
//
//  Created by tigi on 13/02/2019.
//  Copyright © 2019 tigi. All rights reserved.
//

#import "CMTabOverViewCollectionViewCell.h"


static CGFloat kBoundViewMargin = 20;
static CGFloat kCellSize = 200.f;

@implementation CMTabOverViewCollectionViewCell

- (instancetype)initWithFrame:(CGRect)aFrame
{
    self = [super initWithFrame:aFrame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setClipsToBounds:YES];
        
        self.translatesAutoresizingMaskIntoConstraints = NO;
        [NSLayoutConstraint activateConstraints:@[[self.widthAnchor constraintEqualToConstant:kCellSize],
                                                  [self.heightAnchor constraintEqualToConstant:kCellSize]
                                                  ]];
        self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
        [NSLayoutConstraint activateConstraints:@[[self.contentView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
                                                  [self.contentView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
                                                  [self.contentView.topAnchor constraintEqualToAnchor:self.topAnchor],
                                                  [self.contentView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor]
                                                  ]];
        
        [self setupBoundButton];
        [self setupWebImageView];
        [self setupCloseButton];
        [self setupTitleLabel];
    }
    return self;
}


#pragma mark - override


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [NSLayoutConstraint activateConstraints:@[[_closeButton.widthAnchor constraintEqualToAnchor:_titleLabel.heightAnchor multiplier:1],
                                              [_closeButton.heightAnchor constraintEqualToAnchor:_titleLabel.heightAnchor multiplier:1]]];
}


#pragma mark - setup


- (void)setupBoundButton
{
    _boundButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_boundButton setBackgroundColor:[UIColor grayColor]];
    [_boundButton.layer setBorderWidth:1.0f];
    [_boundButton.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    
    [self.contentView addSubview:_boundButton];
    
    _boundButton.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[[_boundButton.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:kBoundViewMargin],
                                              [_boundButton.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-kBoundViewMargin],
                                              [_boundButton.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:kBoundViewMargin],
                                              [_boundButton.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-kBoundViewMargin]
                                              ]];
}

- (void)setupWebImageView
{
    _webImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [_webImageView setClipsToBounds:YES];
    
    [_boundButton addSubview:_webImageView];
    
    _webImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[[_webImageView.leadingAnchor constraintEqualToAnchor:_boundButton.leadingAnchor],
                                              [_webImageView.topAnchor constraintEqualToAnchor:_boundButton.topAnchor],
                                              [_webImageView.trailingAnchor constraintEqualToAnchor:_boundButton.trailingAnchor],
                                              [_webImageView.bottomAnchor constraintEqualToAnchor:_boundButton.bottomAnchor]
                                              ]];
}

- (void)setupCloseButton
{
    _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_closeButton setImage:[UIImage imageNamed:@"closeButtonImage"] forState:UIControlStateNormal];
    [_closeButton setBackgroundColor:[UIColor colorWithRed:255 green:255 blue:255 alpha:0.1]];
    
    [_boundButton addSubview:_closeButton];
    
    _closeButton.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[[_closeButton.leadingAnchor constraintEqualToAnchor:_boundButton.leadingAnchor],
                                              [_closeButton.topAnchor constraintEqualToAnchor:_boundButton.topAnchor]
                                              ]];
}

- (void)setupTitleLabel
{
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [_titleLabel setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]];
    [_titleLabel setFont:[UIFont systemFontOfSize:15.f]];
    [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    [_boundButton addSubview:_titleLabel];
    
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[[_titleLabel.leadingAnchor constraintEqualToAnchor:_closeButton.trailingAnchor],
                                              [_titleLabel.topAnchor constraintEqualToAnchor:_boundButton.topAnchor],
                                              [_titleLabel.trailingAnchor constraintEqualToAnchor:_boundButton.trailingAnchor]
                                              ]];
}

@end
