//
//  LHLSettingViewController.m
//  百思不得姐(环境部署)
//
//  Created by admin on 16/9/15.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "LHLSettingViewController.h"
#import "SDImageCache.h"
#import "UIImageView+WebCache.h"
#import "LHLFileTool.h"
#import <SVProgressHUD/SVProgressHUD.h>

#define CachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

@interface LHLSettingViewController ()

@property (nonatomic, assign) NSInteger totalSize;

@end

static NSString * const ID = @"cell";
@implementation LHLSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 设置标题
    self.title = @"设置";
    
    // 注册cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    [SVProgressHUD showWithStatus:@"正在计算中..."];
    
    // 计算缓存尺寸
    [LHLFileTool getFileSize:CachePath completion:^(NSInteger totalSize) {
        
        _totalSize = totalSize;
        // 刷新数据
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    }];
    
    
}





#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    
//    NSInteger fileSize = [SDImageCache sharedImageCache].getSize;
//    NSLog(@"%ld", fileSize);
   
    cell.textLabel.text = [self sizeStr];
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 删除数据
    [LHLFileTool removeDirectoryPath:CachePath];
    
    _totalSize = 0;
    
    [self.tableView reloadData];
    
}





// 计算缓存尺寸显示格式 / MB / KB / B
- (NSString *)sizeStr{

    NSString *sizeStr = @"清除缓存";
    
    if (_totalSize > 1000.0 * 1000.0) {
        // MB
        CGFloat size = _totalSize / 1000.0 / 1000.0;
        sizeStr = [NSString stringWithFormat:@"%@(%.1fMB)", sizeStr, size];
        
    }else if (_totalSize > 1000.0){
        // KB
        CGFloat size = _totalSize / 1000.0;
        sizeStr = [NSString stringWithFormat:@"%@(%.1fKB)", sizeStr, size];
    }else if (_totalSize > 0){
        // B
        sizeStr = [NSString stringWithFormat:@"%@(%ldKB)", sizeStr, _totalSize];
    }
    
    return sizeStr;
}


@end











