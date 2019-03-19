//
//  CMURLTextField.m
//  CustomMultipleWebViewExample
//
//  Created by tigi on 19/03/2019.
//  Copyright © 2019 tigi. All rights reserved.
//

#import "CMURLTextField.h"


static CGFloat kRefreshButtonMarginRight = 8.f;


@implementation CMURLTextField

- (instancetype)initWithFrame:(CGRect)aFrame
{
    self = [super initWithFrame:aFrame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.94 alpha:1];
        self.borderStyle = UITextBorderStyleRoundedRect;
        self.font = [UIFont systemFontOfSize:15];
        self.textColor = [UIColor darkGrayColor];
        self.placeholder = @"URL";
        self.autocorrectionType = UITextAutocorrectionTypeNo;
        self.keyboardType = UIKeyboardTypeDefault;
        self.returnKeyType = UIReturnKeyDone;
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        [self setupRefreshButton];
    }
    return self;
}

- (CGRect)rightViewRectForBounds:(CGRect)aBounds
{
    CGFloat sRightViewWidth = CGRectGetHeight(aBounds) * 0.4;
    CGPoint sRIghtViewPoint = CGPointMake(CGRectGetMaxX(aBounds) - sRightViewWidth - kRefreshButtonMarginRight, (CGRectGetHeight(aBounds) - sRightViewWidth) / 2);
    
    return CGRectMake(sRIghtViewPoint.x, sRIghtViewPoint.y, sRightViewWidth, sRightViewWidth);
}

#pragma mark - setup


- (void)setupRefreshButton
{
    _refreshButton = [[CMRefreshButton alloc] initWithFrame:CGRectZero];
    
    self.rightView = _refreshButton;
    self.rightViewMode = UITextFieldViewModeUnlessEditing;
}

@end
