//
//  UIImage+image.m
//  百思不得姐(环境部署)
//
//  Created by admin on 16/9/13.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "UIImage+image.h"

@implementation UIImage (image)

// 不要系统自动渲染
+ (UIImage *)imageOriginalWithName:(NSString *)imageName{
    
    UIImage *image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
}
- (instancetype)lhl_circleImage
{
    // 裁剪圆形图片
    // 1.开启上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 1);
    // 2.描述裁剪区域
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    // 3.设置裁剪区域
    [path addClip];
    // 4.画图片
    [self drawAtPoint:CGPointZero];
    // 5.取出图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 6.关闭上下文
    UIGraphicsEndImageContext();
    
    return image;
}

+ (instancetype)lhl_circleImageNamed:(NSString *)name{
    
    return [[self imageNamed:name] lhl_circleImage];
}

@end
