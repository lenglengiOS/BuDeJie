//
//  LHLTopicVideoView.m
//  百思不得姐(环境部署)
//
//  Created by admin on 16/9/24.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "LHLTopicPictureView.h"
#import <AFNetworking/AFNetworking.h>
#import "UIImageView+WebCache.h"
#import "LHLTopicsItem.h"

@interface LHLTopicPictureView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigPictureButton;

@end

@implementation LHLTopicPictureView

- (void)awakeFromNib{
    self.autoresizingMask = UIViewAutoresizingNone;
}
- (void)setTopic:(LHLTopicsItem *)topic{
    _topic = topic;
    
    // 设置图片
    UIImage *placeholder = nil;
    [self.imageView lhl_setOriginImage:topic.image1 thumbnailImage:topic.image0 placeholder:placeholder];
    // 处理超长图片的大小
    if (topic.isBigPicture) {
        CGFloat imageW = topic.middleFrame.size.width;
        CGFloat imageH =imageW * topic.height / topic.width;
        CGSize size = CGSizeMake(topic.middleFrame.size.width, imageH);
        UIGraphicsBeginImageContext(size);
        // 绘制图片到上下文中
        [self.imageView.image drawInRect:CGRectMake(0, 0, imageW, imageH)];
        self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        // 关闭上下文
        UIGraphicsEndImageContext();
    }
    
    // gif
    self.gifView.hidden = !topic.is_gif;
    
    // 超长图片
    if (topic.isBigPicture) { // 是超长图
        self.seeBigPictureButton.hidden = NO;
        self.imageView.contentMode = UIViewContentModeTop;
        self.imageView.clipsToBounds = YES;
        
    }else{ // 不是超长图
        self.seeBigPictureButton.hidden = YES;
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        self.imageView.clipsToBounds = NO;
    }
    
}

@end
