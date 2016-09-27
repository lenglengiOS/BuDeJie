//
//  LHLLoginRegisterView.m
//  百思不得姐(环境部署)
//
//  Created by admin on 16/9/16.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "LHLLoginRegisterView.h"

@interface LHLLoginRegisterView ()

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation LHLLoginRegisterView

- (void)awakeFromNib{
    
    UIImage *image = _loginBtn.currentBackgroundImage;
    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    
    // 设置按钮背景图片 不要被拉伸
    [_loginBtn setBackgroundImage:image forState:UIControlStateNormal];
    
    
}

+ (instancetype)loadView{
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
    
}

+ (instancetype)registerView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

@end
