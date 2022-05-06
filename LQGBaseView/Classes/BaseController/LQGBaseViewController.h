//
//  LQGBaseViewController.h
//  LQGBaseView
//
//  Created by 罗建
//  Copyright (c) 2021 罗建. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <LQGBaseView/LQGInitProtocol.h>

@interface LQGBaseViewController : UIViewController
<
LQGInitProtocol
>

/// 是否禁止侧滑返回手势
- (BOOL)lqg_interactivePopDisabled;

/// 是否隐藏状态栏
- (BOOL)lqg_prefersStatusBarHidden;

/// 状态栏样式
- (UIStatusBarStyle)lqg_preferredStatusBarStyle;

/// 是否隐藏导航栏
@property (nonatomic, assign) BOOL lqg_prefersNavigationBarHidden;

/// 是否使用自定义导航栏
@property (nonatomic, assign) BOOL lqg_prefersNavigationBarCustom;

/// 设置导航栏
- (void)lqg_setupNavigationBar;

/// 导航栏
- (UINavigationBar *)navigationBar;

/// 重新设置导航栏Item（仅限调用，请勿重写）
- (void)lqg_resetNavigationBarItem;

/// 设置导航栏Item
- (void)lqg_setupNavigationBarItem;

/// 是否需要返回按钮
- (BOOL)lqg_needLeftBarButtonItem;

/// leftBarButtonItem
- (UIBarButtonItem *)leftBarButtonItem;

/// leftBarButtonItem点击事件（默认pop）
- (void)lqg_leftBarButtonItemAction;

/// 关闭自己
- (void)closeSelf;

/// 关闭从自己往前几个界面（包含自己）
/// @param count 数量
- (void)closeControllersWithCount:(NSInteger)count;

@end
