//
//  LQGBaseTabBarController.m
//  LQGBaseView
//
//  Created by 罗建
//  Copyright (c) 2021 罗建. All rights reserved.
//

#import "LQGBaseTabBarController.h"

#import <LQGMacro/LQGMacro.h>

@implementation LQGBaseTabBarController


#pragma mark - 横竖屏

- (BOOL)shouldAutorotate {
    return self.selectedViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.selectedViewController.supportedInterfaceOrientations;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return self.selectedViewController.preferredInterfaceOrientationForPresentation;
}


#pragma mark - StatusBar

- (BOOL)prefersStatusBarHidden {
    return [self.selectedViewController prefersStatusBarHidden];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return [self.selectedViewController preferredStatusBarStyle];
}


#pragma mark - Life Cycle

- (void)dealloc {
    LQG_DebugLog(@"%@已释放", NSStringFromClass([self class]));
}

@end
