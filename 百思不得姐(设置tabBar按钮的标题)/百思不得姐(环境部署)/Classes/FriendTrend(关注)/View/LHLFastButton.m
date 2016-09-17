//
//  LHLFastButton.m
//  百思不得姐(环境部署)
//
//  Created by admin on 16/9/16.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "LHLFastButton.h"

@implementation LHLFastButton

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.imageView.lhl_y = 0;
    self.imageView.lhl_centerX = self.lhl_width * 0.5;
    
    self.titleLabel.lhl_y = self.imageView.lhl_height;
    [self.titleLabel sizeToFit];
    
    self.titleLabel.lhl_centerX = self.lhl_width * 0.5;
}


@end
