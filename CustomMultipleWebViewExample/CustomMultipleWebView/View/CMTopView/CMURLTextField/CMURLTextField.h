//
//  CMURLTextField.h
//  CustomMultipleWebViewExample
//
//  Created by tigi on 19/03/2019.
//  Copyright © 2019 tigi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMRefreshButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface CMURLTextField : UITextField

@property(nonatomic, readonly) CMRefreshButton *refreshButton;

@end

NS_ASSUME_NONNULL_END
