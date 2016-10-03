//
//  UIImageView+download.m
//  百思不得姐(环境部署)
//
//  Created by admin on 16/9/25.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "UIImageView+download.h"
#import <AFNetworking/AFNetworking.h>
#import "UIImageView+WebCache.h"

@implementation UIImageView (download)

- (void)lhl_setOriginImage:(NSString *)originImageURL thumbnailImage:(NSString *)thumbnailImageURL placeholder:(UIImage *)placeholder
{
    // 根据网络状态来加载图片
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    // 获得原图（SDWebImage的图片缓存是用图片的url字符串作为key）
    UIImage *originImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:originImageURL];
    if (originImage) { // 原图已经被下载过
        self.image = originImage;
    } else { // 原图并未下载过
        if (mgr.isReachableViaWiFi) {
            [self sd_setImageWithURL:[NSURL URLWithString:originImageURL] placeholderImage:placeholder];
        } else if (mgr.isReachableViaWWAN) {
#warning downloadOriginImageWhen3GOr4G配置项的值需要从沙盒里面获取
            // 3G\4G网络下时候要下载原图
            BOOL downloadOriginImageWhen3GOr4G = YES;
            if (downloadOriginImageWhen3GOr4G) {
                [self sd_setImageWithURL:[NSURL URLWithString:originImageURL] placeholderImage:placeholder];
            } else {
                [self sd_setImageWithURL:[NSURL URLWithString:thumbnailImageURL] placeholderImage:placeholder];
            }
        } else { // 没有可用网络
            UIImage *thumbnailImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:thumbnailImageURL];
            if (thumbnailImage) { // 缩略图已经被下载过
                self.image = thumbnailImage;
            } else { // 没有下载过任何图片
                // 占位图片;
                self.image = placeholder;
            }
        }
    }
}

// 设置圆形头像
- (void)lhl_setHeader:(NSString *)headerUrl{
    
    UIImage *placeholder = [UIImage lhl_circleImageNamed:@"defaultUserIcon"];
    [self sd_setImageWithURL:
     [NSURL URLWithString:headerUrl]placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
         // 如果加载失败，直接返回
         if (!image) return;
         // 裁剪头像
         self.image = [image lhl_circleImage];     
     }];
}

@end
