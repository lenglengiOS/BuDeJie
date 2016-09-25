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
    
    // gif
    self.gifView.hidden = !self.topic.is_gif;
    
    // 超长图片
    if (self.topic.isBigPicture) {
        self.seeBigPictureButton.hidden = NO;
        self.imageView.contentMode = UIViewContentModeTop;
        self.imageView.clipsToBounds = YES;
    }else{
        self.seeBigPictureButton.hidden = YES;
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        self.imageView.clipsToBounds = NO;
    }
    
}

@end
