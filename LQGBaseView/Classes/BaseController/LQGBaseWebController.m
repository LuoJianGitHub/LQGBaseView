//
//  LQGBaseWebController.m
//  LQGBaseView
//
//  Created by 罗建
//  Copyright (c) 2021 罗建. All rights reserved.
//

#import "LQGBaseWebController.h"

#import <WebViewJavascriptBridge/WKWebViewJavascriptBridge.h>

#import <LQGMacro/LQGMacro.h>

@interface LQGBaseWebController ()
<
WKUIDelegate, WKNavigationDelegate
>

@property (nonatomic, strong, readwrite) WKWebView *webView;

@property (nonatomic, strong, readwrite) UIProgressView *progressView;

@property (nonatomic, strong, readwrite) WKWebViewJavascriptBridge *jsBridge;

@property (nonatomic, assign, readwrite) BOOL isLocal;

@property (nonatomic, copy  , readwrite) NSString *url;

@end

@implementation LQGBaseWebController


#pragma mark - FullScreenPop

- (BOOL)lqg_interactivePopDisabled {
    return self.webView.canGoBack;
}


#pragma mark - NavigationBar

- (BOOL)lqg_needLeftBarButtonItem {
    if (self.webView.canGoBack) {
        return YES;
    }
    return [super lqg_needLeftBarButtonItem];
}


#pragma mark - Life Cycle

- (instancetype)initWithIsLocal:(BOOL)isLocal url:(NSString *)url {
    if (self = [super init]) {
        self.isLocal = isLocal;
        self.url = url;
    }
    return self;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.webView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    self.progressView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 1);
}


#pragma mark - <LQGInitProtocol>

- (void)lqg_init {
    [super lqg_init];
    
    [self.view addSubview:self.webView];
    [self.view addSubview:self.progressView];
    
    // 方法注册
    [self registerHandler];
    
    // 开始加载
    if (self.isLocal) {
        [self.webView loadRequest:[NSMutableURLRequest requestWithURL:[NSURL fileURLWithPath:self.url]]];
    } else {
        [self.webView loadRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    }
}

- (void)lqg_addObservers {
    [self.webView addObserver:self
                   forKeyPath:@"title"
                      options:NSKeyValueObservingOptionNew
                      context:nil];
    [self.webView addObserver:self
                   forKeyPath:@"estimatedProgress"
                      options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                      context:nil];
}

- (void)lqg_removeObservers {
    [_webView removeObserver:self
                  forKeyPath:@"title"];
    [_webView removeObserver:self
                  forKeyPath:@"estimatedProgress"];
}

- (void)lqg_dealloc {
    [_webView.configuration.userContentController removeAllUserScripts];
    _webView.navigationDelegate = nil;
    _webView.UIDelegate = nil;
}


#pragma mark - <WKNavigationDelegate>

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    LQG_DebugLog(@"开始加载：%@", webView.URL.absoluteString);
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    LQG_DebugLog(@"加载成功：%@", webView.URL.absoluteString);
    [self lqg_resetNavigationBarItem];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    LQG_DebugLog(@"加载失败：%@", webView.URL.absoluteString);
    [self lqg_resetNavigationBarItem];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    LQG_DebugLog(@"加载失败：%@", webView.URL.absoluteString);
    [self lqg_resetNavigationBarItem];
}


#pragma mark - 观察

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context {
    if ([keyPath isEqual: @"title"] &&
        object == self.webView) {
        self.title = self.webView.title;
    } else if ([keyPath isEqual: @"estimatedProgress"] &&
               object == self.webView) {
        self.progressView.alpha = 1.f;
        [self.progressView setProgress:MAX(self.webView.estimatedProgress, 0.02) animated:YES];
        
        if (self.webView.estimatedProgress >= 1.f) {
            [UIView animateWithDuration:0.3 animations:^{
                self.progressView.alpha = 0.f;
            } completion:^(BOOL finished) {
                self.progressView.progress = 0.f;
            }];
        }
    }
}


#pragma mark - Response Action

- (void)lqg_leftBarButtonItemAction {
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    } else {
        [super lqg_leftBarButtonItemAction];
    }
}


#pragma mark - Other Method

- (void)registerHandler {
    [self registerHandler:@"方法名" handler:^(id data, void (^responseCallback)(id responseData)) {
        // data 前端穿过来的参数
        if (responseCallback) {
            responseCallback(nil);
        }
    }];
}

- (void)registerHandler:(NSString*)handlerName handler:(void (^)(id data, void (^responseCallback)(id responseData)))handler {
    [self.jsBridge registerHandler:handlerName handler:handler];
}


#pragma mark - Setter/Getter

- (NSString *)url {
    return [_url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}


#pragma mark - Lazy

- (WKWebView *)webView {
    if (!_webView) {
        _webView = ({
            WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectZero
                                                    configuration:[[WKWebViewConfiguration alloc] init]];
            webView.scrollView.showsVerticalScrollIndicator = NO;
            webView.scrollView.showsHorizontalScrollIndicator = NO;
            webView.scrollView.bounces = YES;
            webView.UIDelegate = self;
            webView.navigationDelegate = self;
            webView;
        });
    }
    return _webView;
}

- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = ({
            UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectZero];
            progressView.trackTintColor = [UIColor clearColor];
            progressView.progressTintColor = [UIColor orangeColor];
            progressView;
        });
    }
    return _progressView;
}

- (WKWebViewJavascriptBridge *)jsBridge {
    if (!_jsBridge) {
        _jsBridge = ({
            // 设置第三方Bridge是否可用
            [WKWebViewJavascriptBridge enableLogging];
            // 关联webView和bridge
            WKWebViewJavascriptBridge *jsBridge = [WKWebViewJavascriptBridge bridgeForWebView:self.webView];
            [jsBridge setWebViewDelegate:self];
            jsBridge;
        });
    }
    return _jsBridge;
}

@end
