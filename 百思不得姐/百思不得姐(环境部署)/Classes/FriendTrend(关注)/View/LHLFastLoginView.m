//
//  LHLFastLoginView.m
//  百思不得姐(环境部署)
//
//  Created by admin on 16/9/16.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "LHLFastLoginView.h"

@implementation LHLFastLoginView
+(instancetype)fastLoginView{
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

@end
