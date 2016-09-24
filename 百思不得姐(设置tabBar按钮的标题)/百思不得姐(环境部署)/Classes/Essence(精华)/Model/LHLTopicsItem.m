//
//  LHLTopicsItem.m
//  百思不得姐(环境部署)
//
//  Created by admin on 16/9/21.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "LHLTopicsItem.h"

@implementation LHLTopicsItem

- (CGFloat)cellHeight{
    
    if (_cellHeight) return _cellHeight;

    // 正文的Y值
    _cellHeight += 55;
    // 最大宽度
    CGSize textMaxSize = CGSizeMake(LHLScreenW - 2 * LHLMargin, MAXFLOAT);
    // 正文高度
    _cellHeight += ([self.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]} context:nil].size.height + LHLMargin);

    // 评论内容
    NSDictionary *topCmt = self.top_cmt.firstObject;
    
    if (self.top_cmt.count) {
        
        // 最热评论
        _cellHeight += 21 + LHLMargin;
        NSString *content = topCmt[@"content"];
        if (content.length == 0) {
            content = @"语音评论";
        }
        NSString *username = topCmt[@"user"][@"username"];
        NSString *topCmtText = [NSString stringWithFormat:@"%@: %@", username, content];
        _cellHeight += ([topCmtText boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]} context:nil].size.height);
    }else{
        
    }
   
    // 工具条
    _cellHeight += 35 + LHLMargin;

    return _cellHeight;
}

@end
