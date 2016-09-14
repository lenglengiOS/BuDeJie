//
//  LHLTabBar.m
//  百思不得姐(环境部署)
//
//  Created by admin on 16/9/14.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "LHLTabBar.h"
#import "UIView+frame.h"


@interface LHLTabBar ()

@property (nonatomic, weak) UIButton *plusButton;

@end

@implementation LHLTabBar

- (UIButton *)plusButton{
    
    if (_plusButton == nil) {
        UIButton *plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        
        // 让按钮的大小根据图片大小来展示
        [plusButton sizeToFit];
        
        _plusButton = plusButton;
        [self addSubview:plusButton];
        
        
    }
    
    return _plusButton;
    
}


- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    // 子控件个数
    NSInteger count = self.items.count + 1;
    // 子控件宽度
    CGFloat btnW = self.lhl_width / count;
    // 子控件高度
    CGFloat btnH = self.lhl_height;
    // 子控件x值
    CGFloat btnX = 0;
    
    NSInteger i = 0;
    for (UIView *tabBarButton in self.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            if (i == 2) {
                i += 1;
            }
            btnX = i * btnW;
            tabBarButton.frame = CGRectMake(btnX, 0, btnW, btnH);
            i++;
        }
    }
    
    // 设置发布按钮的位置
    self.plusButton.center = CGPointMake(self.lhl_width * 0.5, self.lhl_height * 0.5);
    
}

@end







