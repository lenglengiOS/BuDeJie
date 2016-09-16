//
//  LHLLoginField.m
//  百思不得姐(环境部署)
//
//  Created by admin on 16/9/16.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "LHLLoginField.h"

@implementation LHLLoginField


- (void)awakeFromNib{
    

    
    // 1.光标指示器的颜色
    self.tintColor = [UIColor whiteColor];
    
    // 2.占位符的颜色
    
    // 开始编辑
    [self addTarget:self action:@selector(textBegin) forControlEvents:UIControlEventEditingDidBegin];
    // 结束编辑
    [self addTarget:self action:@selector(textEnd) forControlEvents:UIControlEventEditingDidEnd];
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    
//    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attrs];

    
}

// 文本框开始调用
- (void)textBegin{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attrs];
}

// 文本框结束调用
- (void)textEnd{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attrs];
}


@end








