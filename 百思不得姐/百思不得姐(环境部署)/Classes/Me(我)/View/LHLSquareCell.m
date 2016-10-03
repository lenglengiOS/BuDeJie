//
//  LHLSquareCell.m
//  百思不得姐(环境部署)
//
//  Created by admin on 16/9/16.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "LHLSquareCell.h"
#import "UIImageView+WebCache.h"
#import "LHLSquarItem.h"


@interface LHLSquareCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;

@end

@implementation LHLSquareCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setItem:(LHLSquarItem *)item{
    
    _item = item;
    [_iconView sd_setImageWithURL:[NSURL URLWithString:item.icon]];
    self.nameView.text = item.name;
    
}

@end
