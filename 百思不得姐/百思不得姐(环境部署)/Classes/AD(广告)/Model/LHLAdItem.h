//
//  LHLAdItem.h
//  百思不得姐(环境部署)
//
//  Created by admin on 16/9/15.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LHLAdItem : NSObject

/*广告地址*/
@property (nonatomic, strong) NSString *w_picurl;
/*广告链接*/
@property (nonatomic, strong) NSString *ori_curl;
/*广告地址*/
@property (nonatomic, assign) CGFloat w;
/*广告地址*/
@property (nonatomic, assign) CGFloat h;

@end
