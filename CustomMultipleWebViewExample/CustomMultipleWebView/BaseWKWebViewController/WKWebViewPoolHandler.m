//
//  WKWebViewPoolHandler.m
//  CustomMultipleWebViewExample
//
//  Created by tigi on 01/02/2019.
//  Copyright © 2019 tigi. All rights reserved.
//

#import "WKWebViewPoolHandler.h"

@implementation WKWebViewPoolHandler

+ (WKProcessPool *)pool
{
    static WKProcessPool *sWKProcessPool;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sWKProcessPool = [[WKProcessPool alloc] init];
    });
    
    return sWKProcessPool;
}

@end
