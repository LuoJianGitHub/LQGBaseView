//
//  LQGBaseWebController.h
//  LQGBaseView
//
//  Created by 罗建
//  Copyright (c) 2021 罗建. All rights reserved.
//

#import "LQGBaseViewController.h"

@class WKWebView;

@interface LQGBaseWebController : LQGBaseViewController

@property (nonatomic, strong, readonly) WKWebView *webView;

@property (nonatomic, strong, readonly) UIProgressView *progressView;

/// 是否是本地
@property (nonatomic, assign, readonly) BOOL isLocal;

/// 本地路径或者远程链接
@property (nonatomic, copy  , readonly) NSString *url;

/// 初始化
/// @param isLocal 是否是本地路径
/// @param url 路径
- (instancetype)initWithIsLocal:(BOOL)isLocal url:(NSString *)url;

/// 方法注册
- (void)registerHandler;

/// 注册方法
/// @param handlerName 方法名称
/// @param handler 回调
- (void)registerHandler:(NSString*)handlerName
                handler:(void (^)(id data, void (^responseCallback)(id responseData)))handler;

@end
