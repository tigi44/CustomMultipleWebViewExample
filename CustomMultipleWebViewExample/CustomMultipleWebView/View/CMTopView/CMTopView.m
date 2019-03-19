//
//  CMTopView.m
//  CustomMultipleWebViewExample
//
//  Created by tigi on 07/02/2019.
//  Copyright © 2019 tigi. All rights reserved.
//

#import "CMTopView.h"

static CGFloat kStackViewSpacing = 20.f;
static CGFloat kBorderBottomLineHeight = 1.f;
static CGFloat kRefreshButtonMarginRight = 8.f;

@implementation CMTopView
{
    UIStackView *mStackView;
}

- (instancetype)initWithFrame:(CGRect)aFrame
{
    self = [super initWithFrame:aFrame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setClipsToBounds:YES];
        
        [self setupSubViews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    return [self initWithFrame:CGRectZero];
}


#pragma mark - SETUP


- (void)setupSubViews
{
    mStackView = [[UIStackView alloc] init];
    mStackView.axis = UILayoutConstraintAxisHorizontal;
    mStackView.distribution = UIStackViewDistributionFill;
    mStackView.spacing = kStackViewSpacing;
    mStackView.alignment = UIStackViewAlignmentCenter;
    
    [self addSubview:mStackView];
    
    mStackView.translatesAutoresizingMaskIntoConstraints = NO;
    [mStackView.topAnchor constraintEqualToAnchor:self.topAnchor constant:0.f].active = YES;
    [mStackView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:0.f].active = YES;
    [mStackView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:kStackViewSpacing/2].active = YES;
    [mStackView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-kStackViewSpacing/2].active = YES;
    
    _borderBottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    _borderBottomLineView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.1f];
    
    [self addSubview:_borderBottomLineView];
    
    _borderBottomLineView.translatesAutoresizingMaskIntoConstraints = NO;
    [_borderBottomLineView.heightAnchor constraintEqualToConstant:kBorderBottomLineHeight].active = YES;
    [_borderBottomLineView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-kBorderBottomLineHeight].active = YES;
    [_borderBottomLineView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:0.f].active = YES;
    [_borderBottomLineView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:0.f].active = YES;
    
    [self setupUrlTextField];
    [self setupTabOverViewButton];
    [self setupCloseButton];
}

- (void)setupRefreshButton
{
    _refreshButton = [[CMRefreshButton alloc] initWithFrame:CGRectZero];
    _refreshButton.contentEdgeInsets = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, kRefreshButtonMarginRight);
    
    _refreshButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_refreshButton.widthAnchor constraintEqualToConstant:CGRectGetHeight(self.frame) / 4 + kRefreshButtonMarginRight].active = YES;
    [_refreshButton.heightAnchor constraintEqualToConstant:CGRectGetHeight(self.frame) / 4].active = YES;
    
    _urlTextField.rightView = _refreshButton;
    _urlTextField.rightViewMode = UITextFieldViewModeUnlessEditing;
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
    
    _urlTextField.translatesAutoresizingMaskIntoConstraints = NO;
//    [_urlTextField.widthAnchor constraintEqualToConstant:CGRectGetWidth(self.frame) * 3 / 4].active = YES;
    [_urlTextField.heightAnchor constraintEqualToConstant:CGRectGetHeight(self.frame) * 3 / 4].active = YES;
    
    [mStackView addArrangedSubview:_urlTextField];
    
    [self setupRefreshButton];
}

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
    
    _tabOverViewButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_tabOverViewButton.widthAnchor constraintEqualToConstant:CGRectGetHeight(self.frame) * 3 / 5].active = YES;
    [_tabOverViewButton.heightAnchor constraintEqualToConstant:CGRectGetHeight(self.frame) * 3 / 5].active = YES;
    [mStackView addArrangedSubview:_tabOverViewButton];
}

- (void)setupCloseButton
{
    _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _closeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
    _closeButton.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
    [[_closeButton imageView] setContentMode:UIViewContentModeScaleAspectFit];
    [_closeButton setImage:[UIImage imageNamed:@"closeButtonImage"] forState:UIControlStateNormal];
    [_closeButton setBackgroundColor:[UIColor whiteColor]];
    
    _closeButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_closeButton.widthAnchor constraintEqualToConstant:CGRectGetHeight(self.frame) * 3 / 5].active = YES;
    [_closeButton.heightAnchor constraintEqualToConstant:CGRectGetHeight(self.frame) * 3 / 5].active = YES;
    [mStackView addArrangedSubview:_closeButton];
    
}

@end
