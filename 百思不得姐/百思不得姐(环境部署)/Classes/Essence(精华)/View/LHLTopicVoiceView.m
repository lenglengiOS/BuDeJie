//
//  LHLTopicVideoView.m
//  百思不得姐(环境部署)
//
//  Created by admin on 16/9/24.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "LHLTopicVoiceView.h"
#import <AFNetworking/AFNetworking.h>
#import "UIImageView+WebCache.h"
#import "LHLTopicsItem.h"
#import "LHLSeeBigPictureViewController.h"

@interface LHLTopicVoiceView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *voicetimeLabel;
@end

@implementation LHLTopicVoiceView

- (void)awakeFromNib{
    self.autoresizingMask = UIViewAutoresizingNone;
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBigPicture)]];
}
- (void)seeBigPicture{
   
    LHLSeeBigPictureViewController *seeBigPictureVC = [[LHLSeeBigPictureViewController alloc] init];
    seeBigPictureVC.topic = self.topic;
    [self.window.rootViewController presentViewController:seeBigPictureVC animated:YES completion:nil];
}

- (void)setTopic:(LHLTopicsItem *)topic{
    _topic = topic;
    // 设置图片
    UIImage *placeholder = nil;
    [self.imageView lhl_setOriginImage:topic.image1 thumbnailImage:topic.image0 placeholder:placeholder];
    
    // 播放数量
    if (topic.playcount > 10000) { // 播放次数大于10000
        self.playcountLabel.text = [NSString stringWithFormat:@"%.1lf万播放", topic.playcount /10000.0];
    }else{ // 播放次数小于10000
        self.playcountLabel.text = [NSString stringWithFormat:@"%zd播放", topic.playcount];
    }
    
    self.voicetimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", topic.voicetime / 60, topic.voicetime % 60];
}


@end
