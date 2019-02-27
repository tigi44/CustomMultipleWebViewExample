//
//  CMWebViewController+UITextFieldDelegate.m
//  CustomMultipleWebViewExample
//
//  Created by tigi on 07/02/2019.
//  Copyright © 2019 tigi. All rights reserved.
//

#import "CMWebViewController+UITextFieldDelegate.h"


@interface CMWebViewController()

- (void)loadWebView:(NSURL *)aURL;

@end

@implementation CMWebViewController (UITextFieldDelegate)

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"textFieldDidBeginEditing : %@", textField.text);
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"textFieldDidEndEditing : %@", textField.text);
    
    NSURL *sURL = [NSURL URLWithString:textField.text];
    
    if ([sURL.absoluteString length] > 0)
    {
        if ([sURL scheme] == nil)
        {
            NSURLComponents *sURLComponents = [NSURLComponents componentsWithURL:sURL resolvingAgainstBaseURL:YES];
            sURLComponents.scheme = @"http";
            sURL = [sURLComponents URL];
        }
        
        [self loadWebView:sURL];
    }
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

@end
