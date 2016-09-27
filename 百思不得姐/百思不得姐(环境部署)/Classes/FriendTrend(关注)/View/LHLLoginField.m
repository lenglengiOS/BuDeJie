//
//  LHLLoginField.m
//  百思不得姐(环境部署)
//
//  Created by admin on 16/9/16.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "LHLLoginField.h"
#import "UITextField+placeholder.h"

@implementation LHLLoginField


- (void)awakeFromNib{
    

    
    // 1.光标指示器的颜色
    self.tintColor = [UIColor whiteColor];
    
    // 2.占位符的颜色
    
    // 开始编辑
    [self addTarget:self action:@selector(textBegin) forControlEvents:UIControlEventEditingDidBegin];
    // 结束编辑
    [self addTarget:self action:@selector(textEnd) forControlEvents:UIControlEventEditingDidEnd];
    
    self.placeholderColor = [UIColor lightGrayColor];

}

// 文本框开始调用
- (void)textBegin{
    self.placeholderColor = [UIColor whiteColor];
}

// 文本框结束调用
- (void)textEnd{
    self.placeholderColor = [UIColor lightGrayColor];
}


@end








