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
    
    _cellHeight += ([self.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]} context:nil].size.height + LHLMargin);
   
    // 工具条
    _cellHeight += 35 + LHLMargin;
    LHLFunc
    return _cellHeight;
}

@end
