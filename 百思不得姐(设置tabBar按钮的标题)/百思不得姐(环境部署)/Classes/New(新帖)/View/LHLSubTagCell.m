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

- (void)setFrame:(CGRect)frame{
    
    frame.size.height -= 1;
    
    [super setFrame:frame];
}

- (void)setItem:(LHLSubTagItem *)item{
    
    _item = item;
    _nameLabel.text = item.theme_name;
    
    // 数字显示
    [self resolveNum];
    
    // 加载头像
    [self.iconImageView lhl_setHeader:_item.image_list];
}

// 数字显示
- (void)resolveNum{
    NSInteger num = _item.sub_number.integerValue;
    if (num > 10000) {
        
        CGFloat numF = num / 10000.0;
        _numLabel.text = [NSString stringWithFormat:@"%.1f万人订阅", numF];
        _numLabel.text = [_numLabel.text stringByReplacingOccurrencesOfString:@"0." withString:@""];
        
    }else{
        _numLabel.text = [NSString stringWithFormat:@"%ld人订阅", (long)num];
    }
    
}


// 从xib加载一次就会调用
- (void)awakeFromNib {

    // 圆角头像
//    _iconImageView.layer.cornerRadius = self.iconImageView.frame.size.width * 0.5;
//    _iconImageView.layer.masksToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
