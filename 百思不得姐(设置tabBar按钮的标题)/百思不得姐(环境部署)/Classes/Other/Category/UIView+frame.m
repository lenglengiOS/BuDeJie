//
//  UIView+frame.m
//  百思不得姐(环境部署)
//
//  Created by admin on 16/9/14.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "UIView+frame.h"

@implementation UIView (frame)

+ (instancetype)lhl_viewFromXib{
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (CGFloat)lhl_height{
    
    return self.frame.size.height;
    
}
- (void)setLhl_height:(CGFloat)lhl_height{
    
    CGRect rect = self.frame;
    rect.size.height = lhl_height;
    self.frame = rect;
    
}


- (CGFloat)lhl_width{
    
    return self.frame.size.width;
}
- (void)setLhl_width:(CGFloat)lhl_width{
    
    CGRect rect = self.frame;
    rect.size.width = lhl_width;
    self.frame = rect;
    
}


- (CGFloat)lhl_x{
    
    
    return self.frame.origin.x;
}
- (void)setLhl_x:(CGFloat)lhl_x{
    
    
    CGRect rect = self.frame;
    rect.origin.x = lhl_x;
    self.frame = rect;
    
}

- (CGFloat)lhl_y{
    
    return self.frame.origin.y;
}
- (void)setLhl_y:(CGFloat)lhl_y{
    
    CGRect rect = self.frame;
    rect.origin.y = lhl_y;
    self.frame = rect;
}

- (CGFloat)lhl_centerX{
    return self.center.x;
}
- (void)setLhl_centerX:(CGFloat)lhl_centerX{
    CGPoint center = self.center;
    center.x = lhl_centerX;
    self.center = center;
    
}
- (CGFloat)lhl_centerY{
    return self.center.y;
}

- (void)setLhl_centerY:(CGFloat)lhl_centerY{
    CGPoint center = self.center;
    center.y = lhl_centerY;
    self.center = center;
}



@end






