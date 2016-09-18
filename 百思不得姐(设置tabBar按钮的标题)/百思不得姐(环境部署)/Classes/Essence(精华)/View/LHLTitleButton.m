//
//  LHLTitleButton.m
//  百思不得姐(环境部署)
//
//  Created by admin on 16/9/18.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "LHLTitleButton.h"

@implementation LHLTitleButton

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [self.titleLabel setFont:[UIFont systemFontOfSize:15]];
    }
    return self;
    
}

- (void)setHighlighted:(BOOL)highlighted{
    // 重写这个方法，点击的时候就不会有高亮效果
    
}


@end
