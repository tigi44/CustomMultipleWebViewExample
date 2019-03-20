//
//  CMTopToolBar.m
//  CustomMultipleWebViewExample
//
//  Created by tigi on 19/03/2019.
//  Copyright © 2019 tigi. All rights reserved.
//

#import "CMTopToolBar.h"


static CGFloat kBorderBottomLineHeight = 1.f;

@interface CMTopToolBar()

@property(nonatomic, readwrite) UIView *borderBottomLineView;

@end

@implementation CMTopToolBar

- (instancetype)initWithFrame:(CGRect)aFrame
{
    self = [super initWithFrame:aFrame];
    if (self) {
        [self setBarTintColor:[UIColor whiteColor]];
        [self setClipsToBounds:YES];
        
        [self setupSubViews];
        [self setupToolBarButtonItems];
    }
    return self;
}

- (void)layoutSubviews
{
    [_urlTextField setFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame) * 4 / 5, CGRectGetHeight(self.frame) * 3 / 4)];
}

#pragma mark - setup


- (void)setupSubViews
{
    _borderBottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    _borderBottomLineView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2f];
    
    [self addSubview:_borderBottomLineView];
    
    _borderBottomLineView.translatesAutoresizingMaskIntoConstraints = NO;
    [_borderBottomLineView.heightAnchor constraintEqualToConstant:kBorderBottomLineHeight].active = YES;
    [_borderBottomLineView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-kBorderBottomLineHeight].active = YES;
    [_borderBottomLineView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = YES;
    [_borderBottomLineView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor].active = YES;
    
    [self setupUrlTextField];
}

- (void)setupUrlTextField
{
    _urlTextField = [[CMURLTextField alloc] initWithFrame:CGRectZero];
}

- (void)setupToolBarButtonItems
{
    UIBarButtonItem *sFlSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *sCloseItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(actionClose)];
    UIBarButtonItem *sTextFieldItem = [[UIBarButtonItem alloc] initWithCustomView:_urlTextField];
    
    [sCloseItem setTintColor:[UIColor grayColor]];
    
    [self setItems:@[sCloseItem, sFlSpace, sTextFieldItem]];
}


#pragma mark - action


- (void)actionClose
{
    if (_closeBlock)
    {
        _closeBlock();
    }
}


@end
