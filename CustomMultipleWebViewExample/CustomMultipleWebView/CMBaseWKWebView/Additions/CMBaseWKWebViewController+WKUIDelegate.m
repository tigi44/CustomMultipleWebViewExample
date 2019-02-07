//
//  CMBaseWKWebViewController+WKUIDelegate.m
//  CustomMultipleWebViewExample
//
//  Created by tigi on 01/02/2019.
//  Copyright © 2019 tigi. All rights reserved.
//

#import "CMBaseWKWebViewController+WKUIDelegate.h"

@implementation CMBaseWKWebViewController (WKUIDelegate)

- (void)webView:(WKWebView *)aWebView runJavaScriptAlertPanelWithMessage:(NSString *)aMessage initiatedByFrame:(WKFrameInfo *)aFrame completionHandler:(void (^)(void))aCompletionHandler
{
    UIAlertController *sAlertController = [UIAlertController alertControllerWithTitle:nil message:aMessage preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *sAlertAction = [UIAlertAction actionWithTitle:@"OK"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action) {
                                                             aCompletionHandler();
                                                         }];
    
    [sAlertController addAction:sAlertAction];
    [self presentViewController:sAlertController animated:YES completion:nil];
}


- (void)webView:(WKWebView *)aWebView runJavaScriptConfirmPanelWithMessage:(NSString *)aMessage initiatedByFrame:(WKFrameInfo *)aFrame completionHandler:(void (^)(BOOL))aCompletionHandler
{
    
    UIAlertController *sAlertController = [UIAlertController alertControllerWithTitle:nil message:aMessage preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *sAlertActionOK = [UIAlertAction actionWithTitle:@"OK"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action) {
                                                             aCompletionHandler(YES);
                                                         }];
    
    UIAlertAction *sAlertActionCancel = [UIAlertAction actionWithTitle:@"CANCEL"
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction *action) {
                                                             aCompletionHandler(NO);
                                                         }];
    
    [sAlertController addAction:sAlertActionOK];
    [sAlertController addAction:sAlertActionCancel];
    [self presentViewController:sAlertController animated:YES completion:nil];
}


- (void)webView:(WKWebView *)aWebView runJavaScriptTextInputPanelWithPrompt:(NSString *)aPrompt defaultText:(NSString *)aDefaultText initiatedByFrame:(WKFrameInfo *)aFrame completionHandler:(void (^)(NSString *))aCompletionHandler
{
    UIAlertController *sAlertController = [UIAlertController alertControllerWithTitle:nil message:aPrompt preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *sAlertActionOK = [UIAlertAction actionWithTitle:@"OK"
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction *action) {
                                                               NSString *sInputText = [[sAlertController textFields] firstObject].text;
                                                               aCompletionHandler(sInputText);
                                                           }];
    
    UIAlertAction *sAlertActionCancel = [UIAlertAction actionWithTitle:@"CANCEL"
                                                                 style:UIAlertActionStyleCancel
                                                               handler:^(UIAlertAction *action) {
                                                                   aCompletionHandler(nil);
                                                               }];
    
    [sAlertController addTextFieldWithConfigurationHandler:^(UITextField *aTextField) {
        aTextField.text = aDefaultText;
    }];
    
    [sAlertController addAction:sAlertActionOK];
    [sAlertController addAction:sAlertActionCancel];
    [self presentViewController:sAlertController animated:YES completion:nil];
}


- (WKWebView *)webView:(WKWebView *)aWebView createWebViewWithConfiguration:(WKWebViewConfiguration *)aConfiguration forNavigationAction:(WKNavigationAction *)aNavigationAction windowFeatures:(WKWindowFeatures *)aWindowFeatures
{
    return nil;
}

@end
