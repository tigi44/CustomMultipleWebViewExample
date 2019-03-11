//
//  CMTopView.m
//  CustomMultipleWebViewExample
//
//  Created by tigi on 07/02/2019.
//  Copyright © 2019 tigi. All rights reserved.
//

#import "CMTopView.h"


static CGFloat kURLTextFieldMarginLeft = 20.f;
static CGFloat kCloseButtonMarginRight = 20.f;
static CGFloat kBorderBottomLineHeight = 1.f;
static CGFloat kTabOverViewButtonMarginRight = 30.f;
static CGFloat kTopViewHeight = 50.f;
static CGFloat kRefreshButtonMarginRight = 8.f;

@implementation CMTopView

- (instancetype)initWithFrame:(CGRect)aFrame
{
    self = [super initWithFrame:aFrame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setClipsToBounds:YES];
        
        [self setupUrlTextField];
        [self setupTabOverViewButton];
        [self setupCloseButton];
        [self setupBorderBottomLineView];
        [self setupRefreshButton];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    return [self initWithFrame:CGRectZero];
}

- (void)layoutSubviews
{
    CGFloat sViewWidth = CGRectGetWidth(self.frame);
    CGFloat sViewHeight = CGRectGetHeight(self.frame);
    CGFloat sURLTextFieldPositionY = sViewHeight / 2 - CGRectGetHeight(_urlTextField.frame) / 2;
    CGFloat sCloseButtonPositionX = sViewWidth - CGRectGetWidth(_closeButton.frame) - kCloseButtonMarginRight;
    CGFloat sCloseButtonPositionY = sViewHeight / 2 - CGRectGetHeight(_closeButton.frame) / 2;
    
    [_urlTextField setFrame:CGRectMake(kURLTextFieldMarginLeft, sURLTextFieldPositionY, CGRectGetWidth(_urlTextField.frame), CGRectGetHeight(_urlTextField.frame))];
    [_tabOverViewButton setFrame:CGRectMake(sCloseButtonPositionX - kTabOverViewButtonMarginRight, sCloseButtonPositionY, CGRectGetWidth(_tabOverViewButton.frame), CGRectGetHeight(_tabOverViewButton.frame))];
    [_closeButton setFrame:CGRectMake(sCloseButtonPositionX, sCloseButtonPositionY, CGRectGetWidth(_closeButton.frame), CGRectGetHeight(_closeButton.frame))];
    [_borderBottomLineView setFrame:CGRectMake(0, sViewHeight - kBorderBottomLineHeight, CGRectGetWidth(_borderBottomLineView.frame), CGRectGetHeight(_borderBottomLineView.frame))];
}

- (CGSize)sizeThatFits:(CGSize)aSize
{
    CGFloat sTopViewWidth = aSize.width <= 0 ? [UIScreen mainScreen].bounds.size.width : aSize.width;
    CGFloat sTopViewHeight = aSize.height <= kTopViewHeight ? kTopViewHeight : aSize.height;
    
    [_urlTextField setFrame:CGRectMake(0, 0, sTopViewWidth * 3 / 4, sTopViewHeight * 3 / 4)];
    [_closeButton sizeToFit];
    [_tabOverViewButton setFrame:_closeButton.bounds];
    [_borderBottomLineView setFrame:CGRectMake(0, 0, sTopViewWidth, kBorderBottomLineHeight)];
    [_refreshButton setFrame:CGRectMake(0, 0, sTopViewHeight / 4 + kRefreshButtonMarginRight, sTopViewHeight / 4)];
    
    return CGSizeMake(sTopViewWidth, sTopViewHeight);
}


#pragma mark - SETUP


- (void)setupTabOverViewButton
{
    _tabOverViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_tabOverViewButton setBackgroundColor:[UIColor whiteColor]];
    [_tabOverViewButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_tabOverViewButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [[_tabOverViewButton titleLabel] setFont:[UIFont systemFontOfSize:12.f]];
    [[_tabOverViewButton titleLabel] setAdjustsFontSizeToFitWidth:YES];
    [_tabOverViewButton.layer setBorderWidth:1.f];
    [_tabOverViewButton.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    
    [self addSubview:_tabOverViewButton];
}

- (void)setupCloseButton
{
    _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_closeButton setImage:[UIImage imageNamed:@"closeButtonImage"] forState:UIControlStateNormal];
    [_closeButton setBackgroundColor:[UIColor whiteColor]];
    
    [self addSubview:_closeButton];
}

- (void)setupBorderBottomLineView
{
    _borderBottomLineView = [[UIView alloc] init];
    [_borderBottomLineView setBackgroundColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.1f]];
    
    [self addSubview:_borderBottomLineView];
}

- (void)setupUrlTextField
{
    _urlTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    _urlTextField.borderStyle = UITextBorderStyleRoundedRect;
    _urlTextField.font = [UIFont systemFontOfSize:15];
    _urlTextField.textColor = [UIColor grayColor];
    _urlTextField.placeholder = @"URL";
    _urlTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    _urlTextField.keyboardType = UIKeyboardTypeDefault;
    _urlTextField.returnKeyType = UIReturnKeyDone;
    _urlTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _urlTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;

    [self addSubview:_urlTextField];
}

- (void)setupRefreshButton
{
    _refreshButton = [[CMRefreshButton alloc] initWithFrame:CGRectZero];
    _refreshButton.contentEdgeInsets = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, kRefreshButtonMarginRight);
    
    _urlTextField.rightView = _refreshButton;
    _urlTextField.rightViewMode = UITextFieldViewModeUnlessEditing;
}

@end
