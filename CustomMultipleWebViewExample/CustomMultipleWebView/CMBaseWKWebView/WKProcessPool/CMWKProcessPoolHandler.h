//
//  CMWKProcessPoolHandler.h
//  CustomMultipleWebViewExample
//
//  Created by tigi on 01/02/2019.
//  Copyright © 2019 tigi. All rights reserved.
//

#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CMWKProcessPoolHandler : NSObject

+ (WKProcessPool *)pool;

@end

NS_ASSUME_NONNULL_END
