//
//  LQGInitProtocol.h
//  LQGBaseView
//
//  Created by 罗建
//  Copyright (c) 2021 罗建. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 初始化协议
@protocol LQGInitProtocol <NSObject>

@optional

/// 初始化流程
- (void)lqg_init;

/// 添加子视图
- (void)lqg_addSubviews;

/// 添加观察者
- (void)lqg_addObservers;

/// 移除观察者
- (void)lqg_removeObservers;

/// 销毁
- (void)lqg_dealloc;

@end
