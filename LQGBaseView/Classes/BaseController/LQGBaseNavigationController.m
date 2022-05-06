//
//  LQGBaseNavigationController.m
//  LQGBaseView
//
//  Created by 罗建
//  Copyright (c) 2021 罗建. All rights reserved.
//

#import "LQGBaseNavigationController.h"

#import <LQGMacro/LQGMacro.h>

@implementation LQGBaseNavigationController


#pragma mark - 横竖屏

- (BOOL)shouldAutorotate {
    return self.visibleViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.visibleViewController.supportedInterfaceOrientations;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return self.visibleViewController.preferredInterfaceOrientationForPresentation;
}


#pragma mark - StatusBar

- (BOOL)prefersStatusBarHidden {
    return [self.visibleViewController prefersStatusBarHidden];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return [self.visibleViewController preferredStatusBarStyle];
}


#pragma mark - Life Cycle

- (void)dealloc {
    LQG_DebugLog(@"%@已释放", NSStringFromClass([self class]));
}


#pragma mark - Other Method

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 自动隐藏tabBar
    viewController.hidesBottomBarWhenPushed = self.viewControllers.count == 1;
    [super pushViewController:viewController animated:animated];
    // 处理push在某些版本可能的底部黑屏
    CGRect frame = self.tabBarController.tabBar.frame;
    frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
    self.tabBarController.tabBar.frame = frame;
}

@end
