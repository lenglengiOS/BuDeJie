//
//  LHLTopicsCell.m
//  百思不得姐(环境部署)
//
//  Created by admin on 16/9/22.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "LHLTopicsCell.h"

@implementation LHLTopicsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        // 添加在控件，并设置约束
        [self.contentView addSubview:[[UISwitch alloc] init]];
        UILabel *label = [[UILabel alloc] init];
        label.text = NSStringFromClass(self.class);
        [label sizeToFit];
        label.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:label];
        
    }
    
    return self;
    
}

- (void)setTopic:(LHLTopicsItem *)topic{
    _topic = topic;
    // 设置数据
    
    
}


@end
