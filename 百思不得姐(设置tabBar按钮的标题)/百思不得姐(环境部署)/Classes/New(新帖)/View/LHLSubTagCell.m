//
//  LHLSubTagCell.m
//  百思不得姐(环境部署)
//
//  Created by admin on 16/9/15.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "LHLSubTagCell.h"
#import "LHLSubTagItem.h"
#import "UIImageView+WebCache.h"


@interface LHLSubTagCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;

@end

@implementation LHLSubTagCell

/*
 @property (nonatomic, strong) NSString *image_list;
 @property (nonatomic, strong) NSString *sub_number;
 @property (nonatomic, strong) NSString *theme_name;
 
 */

- (void)setItem:(LHLSubTagItem *)item{
    
    _item = item;
    _nameLabel.text = item.theme_name;
    
//    NSString *numStr = item.sub_number;
    
    NSInteger num = item.sub_number.integerValue;
    if (num > 10000) {

        CGFloat numF = num / 10000.0;
        _numLabel.text = [NSString stringWithFormat:@"%.1f万人订阅", numF];
        _numLabel.text = [_numLabel.text stringByReplacingOccurrencesOfString:@"0." withString:@""];
        
    }else{
        _numLabel.text = [NSString stringWithFormat:@"%ld人订阅", (long)num];
    }
 
    
    
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:item.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
}


// 从xib加载一次酒会调用
- (void)awakeFromNib {

    // 圆角头像
    _iconImageView.layer.cornerRadius = self.iconImageView.frame.size.width * 0.5;
    _iconImageView.layer.masksToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
