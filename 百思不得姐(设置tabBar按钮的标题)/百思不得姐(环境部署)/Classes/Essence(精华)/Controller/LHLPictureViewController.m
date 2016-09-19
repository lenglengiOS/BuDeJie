//
//  LHLPictureViewController.m
//  百思不得姐(环境部署)
//
//  Created by admin on 16/9/19.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "LHLPictureViewController.h"

@interface LHLPictureViewController ()

@end

@implementation LHLPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.contentInset = UIEdgeInsetsMake(LHLNavMaxY + LHLTitlesViewH, 0, LHLTabBarH, 0);
    self.view.backgroundColor = LHLRandomColor;
    
}

#pragma mark - 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 30;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor clearColor];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %ld", self.class, indexPath.row];
    
    return cell;
}

@end
