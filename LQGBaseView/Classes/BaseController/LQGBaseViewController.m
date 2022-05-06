//
//  LQGBaseViewController.m
//  LQGBaseView
//
//  Created by 罗建
//  Copyright (c) 2021 罗建. All rights reserved.
//

#import "LQGBaseViewController.h"

#import <FDFullscreenPopGesture/UINavigationController+FDFullscreenPopGesture.h>

#import <LQGMacro/LQGMacro.h>
#import <LQGCategory/LQGCategory.h>

@interface LQGBaseViewController ()

@property (nonatomic, strong) UINavigationBar *customNavigationBar;

@property (nonatomic, strong) UINavigationItem *customNavigationItem;

@end

@implementation LQGBaseViewController


#pragma mark - 横竖屏

// 是否可以旋转
- (BOOL)shouldAutorotate {
    return YES;
}

// 支持的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

// 由模态推出的视图控制器 优先支持的屏幕方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}


#pragma mark - FullScreenPop

- (BOOL)fd_interactivePopDisabled {
    return [self lqg_interactivePopDisabled];
}

- (BOOL)lqg_interactivePopDisabled {
    return NO;
}


#pragma mark - StatusBar

- (BOOL)prefersStatusBarHidden {
    return [self lqg_prefersStatusBarHidden];
}

- (BOOL)lqg_prefersStatusBarHidden {
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return [self lqg_preferredStatusBarStyle];
}

- (UIStatusBarStyle)lqg_preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationFade;
}


#pragma mark - NavigationBar

- (BOOL)fd_prefersNavigationBarHidden {
    return self.lqg_prefersNavigationBarHidden || [self prefersNavigationBarCustom];
}

- (BOOL)prefersNavigationBarCustom {
    if (self.lqg_prefersNavigationBarHidden) {
        return NO;
    }
    return self.lqg_prefersNavigationBarCustom;
}

- (void)lqg_setupNavigationBar {
    
}

- (void)lqg_resetNavigationBarItem {
    self.navigationItem.leftBarButtonItem = [self lqg_needLeftBarButtonItem] ? self.leftBarButtonItem : [UIBarButtonItem new];
    
    [self lqg_setupNavigationBarItem];
}

- (void)lqg_setupNavigationBarItem {

}

- (BOOL)lqg_needLeftBarButtonItem {
    return self.navigationController.viewControllers.count > 1;
}


#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self lqg_init];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
        
    if (!self.lqg_prefersNavigationBarHidden) {
        [self lqg_setupNavigationBar];
    }
    
    if ([self prefersNavigationBarCustom]) {
        [self.view bringSubviewToFront:self.customNavigationBar];
    }
    
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    if ([self prefersNavigationBarCustom]) {
        self.customNavigationBar.frame = CGRectMake(0, 0, self.view.bounds.size.width, LQG_SS_NAVIGATIONBAR_HEIGHT);
    }
}

- (void)dealloc {
    LQG_DebugLog(@"%@(%@)已释放", NSStringFromClass([self class]), self.title);
    
    [self lqg_removeObservers];
    [self lqg_dealloc];
}


#pragma mark - <LQGInitProtocol>

- (void)lqg_init {
    self.view.backgroundColor = [UIApplication sharedApplication].keyWindow.backgroundColor;
    
    if ([self prefersNavigationBarCustom]) {
        [self.view addSubview:self.customNavigationBar];
    }
    
    [self lqg_addSubviews];
    [self lqg_addObservers];
    [self lqg_resetNavigationBarItem];
}

- (void)lqg_addSubviews {

}

- (void)lqg_addObservers {

}

- (void)lqg_removeObservers {
    
}

- (void)lqg_dealloc {
    
}


#pragma mark - Response Action

- (void)lqg_leftBarButtonItemAction {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Other Method

- (void)closeSelf {
    [self closeControllersWithCount:1];
}

- (void)closeControllersWithCount:(NSInteger)count {
    if (!count) return;
    
    NSMutableArray *viewControllers = [[NSMutableArray alloc] initWithArray:self.navigationController.viewControllers];
    
    for (NSInteger i = 0; i < viewControllers.count; i ++) {
        if (viewControllers[i] == self) {
            [viewControllers removeObjectsInRange:NSMakeRange(i - count + 1, count)];
            break;
        }
    }
    
    self.navigationController.viewControllers = viewControllers;
    self.navigationController.viewControllers.lastObject.hidesBottomBarWhenPushed = YES;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

}


#pragma mark - Setter/Getter

- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    
    if ([self prefersNavigationBarCustom]) {
        self.customNavigationItem.title = title;
    }
}


#pragma mark - Lazy

- (UINavigationBar *)navigationBar {
    if ([self prefersNavigationBarCustom]) {
        return self.customNavigationBar;
    }
    return self.navigationController.navigationBar;
}

- (UINavigationBar *)customNavigationBar {
    if (!_customNavigationBar) {
        _customNavigationBar = [[UINavigationBar alloc] init];
        _customNavigationBar.items = @[self.customNavigationItem];
    }
    return _customNavigationBar;
}

- (UINavigationItem *)navigationItem {
    if ([self prefersNavigationBarCustom]) {
        return self.customNavigationItem;
    }
    return [super navigationItem];
}

- (UINavigationItem *)customNavigationItem {
    if (!_customNavigationItem) {
        _customNavigationItem = [[UINavigationItem alloc] init];
    }
    return _customNavigationItem;
}

- (UIBarButtonItem *)leftBarButtonItem {
    return [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_LQGBaseView_back" bundleForClass:[LQGBaseViewController class] URLForResource:@"LQGBaseView-BaseController"] style:UIBarButtonItemStylePlain target:self action:@selector(lqg_leftBarButtonItemAction)];
}

@end
