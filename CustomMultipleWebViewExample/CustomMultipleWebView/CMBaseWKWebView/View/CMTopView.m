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

@implementation CMTopView

- (instancetype)initWithFrame:(CGRect)aFrame
{
    self = [super initWithFrame:aFrame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setClipsToBounds:YES];
        
        [self setupUrlTextField];
        [self setupCloseButton];
        [self setupBorderBottomLineView];
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
    [_closeButton setFrame:CGRectMake(sCloseButtonPositionX, sCloseButtonPositionY, CGRectGetWidth(_closeButton.frame), CGRectGetHeight(_closeButton.frame))];
    [_borderBottomLineView setFrame:CGRectMake(0, sViewHeight - kBorderBottomLineHeight, CGRectGetWidth(_borderBottomLineView.frame), CGRectGetHeight(_borderBottomLineView.frame))];
}

- (CGSize)sizeThatFits:(CGSize)aSize
{
    [_urlTextField setFrame:CGRectMake(0, 0, aSize.width * 3 / 4, aSize.height * 3 / 4)];
    [_closeButton sizeToFit];
    [_borderBottomLineView setFrame:CGRectMake(0, 0, aSize.width, kBorderBottomLineHeight)];
    
    return aSize;
}


#pragma mark - SETUP


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

@end
