//
//  UITextField+placeholder.m
//  百思不得姐(环境部署)
//
//  Created by admin on 16/9/16.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "UITextField+placeholder.h"

@implementation UITextField (placeholder)

- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    
    UILabel *placeholderLabel = [self valueForKey:@"placeholderLabel"];
    placeholderLabel.textColor = placeholderColor;
    
}

- (UIColor *)placeholderColor{
    
    return nil;
}

@end
