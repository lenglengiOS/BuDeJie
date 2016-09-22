//
//  LHLVideosCell.m
//  百思不得姐(环境部署)
//
//  Created by admin on 16/9/22.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "LHLVideosCell.h"

@implementation LHLVideosCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        // 添加在控件，并设置约束
        self.backgroundColor = [UIColor redColor];
        
    }
    
    return self;
    
}

- (void)setTopic:(LHLTopicsItem *)topic{
    [super setTopic:topic];
    // 设置数据
    
}

@end
