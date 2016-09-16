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


- (void)setItem:(LHLSubTagItem *)item{
    
    _item = item;
    _nameLabel.text = item.theme_name;
    
    // 数字显示
    [self resolveNum];
   
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:_item.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] options:SDWebImageCacheMemoryOnly completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        /*
        // 开启图形上下文
        UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
        
        // 设置路径
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
        
        // 绘制路径
        [path addClip];
        
        // 绘制图片
        [image drawAtPoint:CGPointZero];
        
        // 生成图片
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        
        // 关闭上下文
        UIGraphicsEndImageContext();
        
        _iconImageView.image = newImage;
        */
        
    }];
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
    _iconImageView.layer.cornerRadius = self.iconImageView.frame.size.width * 0.5;
    _iconImageView.layer.masksToBounds = YES;
    // 设置分割线
    self.layoutMargins = UIEdgeInsetsZero;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
