//
//  UIView+frame.h
//  百思不得姐(环境部署)
//
//  Created by admin on 16/9/14.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (frame)

+ (instancetype)lhl_viewFromXib;

@property CGFloat lhl_width;
@property CGFloat lhl_height;
@property CGFloat lhl_x;
@property CGFloat lhl_y;
@property CGFloat lhl_centerX;
@property CGFloat lhl_centerY;

@end
