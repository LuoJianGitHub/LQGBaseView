//
//  LQGBaseTableViewHeaderFooterView.m
//  LQGBaseView
//
//  Created by 罗建
//  Copyright (c) 2021 罗建. All rights reserved.
//

#import "LQGBaseTableViewHeaderFooterView.h"

@implementation LQGBaseTableViewHeaderFooterView


#pragma mark - Life Cycle

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
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
    self.contentView.backgroundColor = [UIApplication sharedApplication].keyWindow.backgroundColor;
    
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
