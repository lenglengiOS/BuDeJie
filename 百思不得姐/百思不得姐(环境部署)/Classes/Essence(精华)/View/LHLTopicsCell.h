//
//  LHLTopicsCell.h
//  百思不得姐(环境部署)
//
//  Created by admin on 16/9/22.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LHLTopicsItem;
@interface LHLTopicsCell : UITableViewCell

/** cell的数据模型 */
@property (nonatomic, strong) LHLTopicsItem *topic;

@end
