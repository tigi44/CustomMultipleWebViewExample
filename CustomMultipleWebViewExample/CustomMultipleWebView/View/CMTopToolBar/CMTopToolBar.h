//
//  CMTopToolBar.h
//  CustomMultipleWebViewExample
//
//  Created by tigi on 19/03/2019.
//  Copyright © 2019 tigi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMURLTextField.h"

NS_ASSUME_NONNULL_BEGIN

@interface CMTopToolBar : UIToolbar

@property(nonatomic, readonly) CMURLTextField *urlTextField;
@property(nonatomic, copy) dispatch_block_t closeBlock;

@end

NS_ASSUME_NONNULL_END
