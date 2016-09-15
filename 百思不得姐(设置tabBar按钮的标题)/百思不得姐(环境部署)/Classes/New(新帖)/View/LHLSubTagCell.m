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
    _numLabel.text = item.sub_number;
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:item.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
