//
//  LHLTopicsCell.m
//  百思不得姐(环境部署)
//
//  Created by admin on 16/9/22.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "LHLTopicsCell.h"
#import "LHLTopicsItem.h"
#import "UIImageView+WebCache.h"
#import "UIImage+image.h"

#import "LHLTopicPictureView.h"
#import "LHLTopicVideoView.h"
#import "LHLTopicVoiceView.h"

@interface LHLTopicsCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *passTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_label;

@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
// 最热评论全部
@property (weak, nonatomic) IBOutlet UIView *topCmtView;
// 最热评论文字
@property (weak, nonatomic) IBOutlet UILabel *topCmtLabel;

/** LHLTopicVoiceView */
@property (nonatomic, weak) LHLTopicVoiceView *voiceView;
/** LHLTopicVoiceView */
@property (nonatomic, weak) LHLTopicVideoView *videoView;
/** LHLTopicVoiceView */
@property (nonatomic, weak) LHLTopicPictureView *pictureView;


@end

@implementation LHLTopicsCell

- (LHLTopicVoiceView *)voiceView{
    if (_voiceView == nil) {
        _voiceView = [LHLTopicVoiceView lhl_viewFeomXib];
    }
    return _voiceView;
}
- (LHLTopicVideoView *)videoView{
    if (_videoView == nil) {
        _videoView = [LHLTopicVideoView lhl_viewFeomXib];
    }
    return _videoView;
}
- (LHLTopicPictureView *)pictureView{
    if (_pictureView == nil) {
        _pictureView = [LHLTopicPictureView lhl_viewFeomXib];
    }
    return _pictureView;
}

- (void)setTopic:(LHLTopicsItem *)topic{
    
    _topic = topic;
    
    // 设置数据
    self.nameLabel.text = topic.name;
    self.passTimeLabel.text = topic.passtime;
    self.text_label.text = topic.text;
    [self setupButtonTitle:self.dingButton dingNumber:topic.ding placeholder:@" 顶"];
    [self setupButtonTitle:self.caiButton dingNumber:topic.ding placeholder:@" 踩"];
    [self setupButtonTitle:self.repostButton dingNumber:topic.ding placeholder:@" 转发"];
    [self setupButtonTitle:self.commentButton dingNumber:topic.ding placeholder:@" 评论"];
    
    // 裁剪占位图片
    UIImage *placeholder = [UIImage lhl_circleImageNamed:@"defaultUserIcon"];
    
    [self.profileImageView sd_setImageWithURL:
     [NSURL URLWithString:topic.profile_image]placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
         // 如果加载失败，直接返回
         if (!image) return;
         // 裁剪头像
         self.profileImageView.image = [image lhl_circleImage];
         
     }];
    
    // 评论内容
    NSDictionary *topCmt = topic.top_cmt.firstObject;
    NSString *content = topCmt[@"content"];
    // 回复的内容是语音消息
    if (content.length == 0) {
        content = @"[语音评论]";
    }
    
    NSString *username = topCmt[@"user"][@"username"];
    NSString *topCmtText = [NSString stringWithFormat:@"%@: %@", username, content];
    self.topCmtLabel.text = topCmtText;
    
    // 最热评论
    if (self.topic.top_cmt.count) {
        self.topCmtView.hidden = NO; // 有最热评论
    }else{
        self.topCmtView.hidden = YES; // 没有最热评论
    }

    // 中间的内容
    if (topic.type == LHLTopicTypePicture) { // 图片
        
        [self.contentView addSubview:self.pictureView];
        self.pictureView.hidden = NO;
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
    }else if (topic.type == LHLTopicTypeVideo) { // 视频
        
        [self.contentView addSubview:self.videoView];
        self.pictureView.hidden = YES;
        self.videoView.hidden = NO;
        self.voiceView.hidden = YES;
    }else if (topic.type == LHLTopicTypeVoice) { // 声音
        
        [self.contentView addSubview:self.voiceView];
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
        self.voiceView.hidden = NO;
    }else if (topic.type == LHLTopicTypeWord) { // 段子
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (self.topic.type == LHLTopicTypePicture) { // 图片
        
        self.pictureView.frame = self.topic.middleFrame;
    }else if (self.topic.type == LHLTopicTypeVoice) { // 声音
        
        self.voiceView.frame = self.topic.middleFrame;
    }else if (self.topic.type == LHLTopicTypeVideo) { // 视频
        
        self.videoView.frame = self.topic.middleFrame;
    }
    
}

/**
 *  @param dingNumber  按钮的数字
 *  @param placeholder 数字为0的时候显示的文字
 */
- (void)setupButtonTitle:(UIButton *)button dingNumber:(NSInteger) dingNumber placeholder:(NSString *)placeholder
{
    if (dingNumber > 10000) {
        [button setTitle:[NSString stringWithFormat:@" %.1f万", dingNumber/ 10000.0] forState:UIControlStateNormal];
    }else if (dingNumber > 0){
        [button setTitle:[NSString stringWithFormat:@" %zd", dingNumber] forState:UIControlStateNormal];
    }else{
        [button setTitle:placeholder forState:UIControlStateNormal];
    }
}

- (void)awakeFromNib{
    // 设置cell的背景图片
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}

- (void)setFrame:(CGRect)frame{
    
    // 设置cell之间的间距
    frame.size.height -= LHLMargin;
    
    [super setFrame:frame];
}


@end






