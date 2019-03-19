//
//  CMRefreshButton.m
//  CustomMultipleWebViewExample
//
//  Created by tigi on 08/03/2019.
//  Copyright © 2019 tigi. All rights reserved.
//

#import "CMRefreshButton.h"

@implementation CMRefreshButton

- (instancetype)initWithFrame:(CGRect)aFrame
{
    self = [super initWithFrame:aFrame];
    if (self) {
        [self setRefreshState:CMRefreshReadyState];
        [self addTarget:self action:@selector(actionButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)setRefreshState:(CMRefreshState)aRefreshState
{
    _refreshState = aRefreshState;
    
    switch (_refreshState) {
        case CMRefreshReadyState:
            [self setImage:[UIImage imageNamed:@"refreshButtonImage"] forState:UIControlStateNormal];
            break;
        case CMRefreshRefreshingState:
            [self setImage:[UIImage imageNamed:@"refreshCancelButtonImage"] forState:UIControlStateNormal];
            break;
    }
}

- (void)actionButton:(CMRefreshButton *)aSender
{
    if (_delegate)
    {
        [_delegate refreshButton:aSender refreshState:_refreshState];
    }
}

@end
