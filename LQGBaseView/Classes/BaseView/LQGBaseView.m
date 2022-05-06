//
//  LQGBaseView.m
//  LQGBaseView
//
//  Created by 罗建
//  Copyright (c) 2021 罗建. All rights reserved.
//

#import "LQGBaseView.h"

@implementation LQGBaseView


#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self lqg_init];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self lqg_init];
}

- (void)dealloc {
    [self lqg_removeObservers];
    [self lqg_dealloc];
}


#pragma mark - 初始化

- (void)lqg_init {
    self.backgroundColor = [UIApplication sharedApplication].keyWindow.backgroundColor;
    
    [self lqg_addSubviews];
    [self lqg_addObservers];
}

- (void)lqg_addSubviews {
    
}

- (void)lqg_addObservers {
    
}

- (void)lqg_removeObservers {
    
}

- (void)lqg_dealloc {
    
}

@end
