//
//  UIImageView+download.h
//  百思不得姐(环境部署)
//
//  Created by admin on 16/9/25.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (download)

// 根据网络状态设置下载图片的质量（小图／大图）
- (void)lhl_setOriginImage:(NSString *)originImageURL thumbnailImage:(NSString *)thumbnailImageURL placeholder:(UIImage *)placeholder;
- (void)lhl_setHeader:(NSString *)headerUrl;

@end
