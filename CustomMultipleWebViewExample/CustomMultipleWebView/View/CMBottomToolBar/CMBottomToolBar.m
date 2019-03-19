//
//  CMBottomToolBar.m
//  CustomMultipleWebViewExample
//
//  Created by tigi on 19/03/2019.
//  Copyright © 2019 tigi. All rights reserved.
//

#import "CMBottomToolBar.h"

@implementation CMBottomToolBar

- (instancetype)initWithFrame:(CGRect)aFrame
{
    self = [super initWithFrame:aFrame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        
        [self setupToolBarButtonItems];
    }
    return self;
}


#pragma mark - private


- (void)setupToolBarButtonItems
{
    UIBarButtonItem *sFlSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *sBackItem = [[UIBarButtonItem alloc] initWithTitle:@"<" style:UIBarButtonItemStylePlain target:self action:@selector(actionToolBarButtonItem:)];
    UIBarButtonItem *sForwardItem = [[UIBarButtonItem alloc] initWithTitle:@">" style:UIBarButtonItemStylePlain target:self action:@selector(actionToolBarButtonItem:)];
    UIBarButtonItem *sReloadItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(actionToolBarButtonItem:)];
    UIBarButtonItem *sTabItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(actionToolBarButtonItem:)];
    
    [sBackItem setTag:CMBottomToolBarButtonItemBack];
    [sForwardItem setTag:CMBottomToolBarButtonItemForward];
    [sReloadItem setTag:CMBottomToolBarButtonItemReload];
    [sTabItem setTag:CMBottomToolBarButtonItemTab];
    
    [self setItems:@[sFlSpace, sBackItem, sFlSpace, sForwardItem, sFlSpace, sFlSpace, sReloadItem, sFlSpace, sTabItem, sFlSpace]];
}


#pragma mark - action


- (void)actionToolBarButtonItem:(UIBarButtonItem *)aSender
{
    if (_toolBarDelegate)
    {
        [_toolBarDelegate bottomToolBar:self tappedIndex:aSender.tag];
    }
}


#pragma mark - public


- (UIBarButtonItem *)barButtonItemAtIndex:(CMBottomToolBarButtonItemIndex)aIndex
{
    UIBarButtonItem *sResult = nil;
    
    for (UIBarButtonItem *sItem in self.items)
    {
        if (sItem.tag == aIndex)
        {
            sResult = sItem;
            break;
        }
    }
    
    return sResult;
}

@end
