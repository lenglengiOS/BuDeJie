//
//  LHLTopicsItem.h
//  百思不得姐(环境部署)
//
//  Created by admin on 16/9/21.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, LHLTopicType) {
    /** 全部 */
    LHLTopicTypeAll = 1,
    /** 音频 */
    LHLTopicTypeVoice = 31,
    /** 图片 */
    LHLTopicTypePicture = 10,
    /** 段子 */
    LHLTopicTypeWord = 29,
    /** 视频 */
    LHLTopicTypeVideo = 41,
};

@interface LHLTopicsItem : NSObject
/** 用户的名字 */
@property (nonatomic, copy) NSString *name;
/** 用户的头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 帖子的文字内容 */
@property (nonatomic, copy) NSString *text;
/** 帖子审核通过的时间 */
@property (nonatomic, copy) NSString *passtime;

/** 顶数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发\分享数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论数量 */
@property (nonatomic, assign) NSInteger comment;
/** 帖子的类型 10为图片 29为段子 31为音频 41为视频 */
@property (nonatomic, assign) NSInteger type;
/** 最热评论 */
@property (nonatomic, strong) NSArray *top_cmt;
/** 宽度 */
@property (nonatomic, assign) NSInteger width;
/** 高度 */
@property (nonatomic, assign) NSInteger height;

/** 小图 */
@property (nonatomic, copy) NSString *image0;
/** 中图 */
@property (nonatomic, copy) NSString *image2;
/** 大图 */
@property (nonatomic, copy) NSString *image1;
/** gif图片 */
@property (nonatomic, assign) BOOL is_gif;

/** 音频时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 视频时长 */
@property (nonatomic, assign) NSInteger videotime;
/** 音频\视频的播放次数 */
@property (nonatomic, assign) NSInteger playcount;


/********** 手动添加的属性（为了方便编程） *********/
/** 缓存cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;
/** 中间图片的frame */
@property (nonatomic, assign) CGRect middleFrame;
/** 超长图片 */
@property (nonatomic, assign, getter=isBigPicture) BOOL bigPicture;

@end
