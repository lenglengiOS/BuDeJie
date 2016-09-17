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
#define CachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

@interface LHLSettingViewController ()

@end

static NSString * const ID = @"cell";
@implementation LHLSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 设置标题
    self.title = @"设置";
    
    // 注册cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    
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
    
    // 删除系统缓存
    NSFileManager *mgr = [NSFileManager defaultManager];
    // 获取caches文件夹下所有文件，不包括子路径的子路径
    NSArray *subPaths = [mgr contentsOfDirectoryAtPath:CachePath error:nil];
    for (NSString *subPath in subPaths) {
        
         NSString *path = [CachePath stringByAppendingPathComponent:subPath];
        [mgr removeItemAtPath:path error:nil];
        
    }
    [self.tableView reloadData];
    
}


// 计算缓存尺寸
- (NSString *)sizeStr{
    
    // 获取Cachaes路径,缓存文件在achaes路径
    NSString *cachePath = CachePath;
    
    NSInteger fileSize = [self getFileSize:cachePath];
    
    NSString *sizeStr = @"清除缓存";
    
    if (fileSize > 1000.0 * 1000.0) {
        // MB
        CGFloat size = fileSize / 1000.0 / 1000.0;
        sizeStr = [NSString stringWithFormat:@"%@(%.1fMB)", sizeStr, size];
        
    }else if (fileSize > 1000.0){
        // KB
        CGFloat size = fileSize / 1000.0;
        sizeStr = [NSString stringWithFormat:@"%@(%.1fKB)", sizeStr, size];
    }else if (fileSize > 0){
        // B
        sizeStr = [NSString stringWithFormat:@"%@(%ldKB)", sizeStr, fileSize];
    }
    
    return sizeStr;
}

// 计算文件的大小
- (NSInteger)getFileSize:(NSString *)directoryPath{
    
    // 获取文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // 获取文件夹下的自路径
    NSArray *subPaths = [mgr subpathsAtPath:directoryPath];
    
    NSInteger totalSize = 0;
    
    for (NSString *subPath in subPaths) {
        
        NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];
        
        // 计算文件的大小
        
        // 判断隐藏文件和文件夹
        if ([filePath containsString:@".DS"]) continue;
        
        BOOL isDirectory;
        
        BOOL isExist = [mgr fileExistsAtPath:filePath isDirectory:&isDirectory];
        if (!isExist || isDirectory) continue;
        
        
        NSDictionary *attr = [mgr attributesOfItemAtPath:filePath error:nil];
        NSInteger fileSize = [attr fileSize];
        
        totalSize += fileSize;
        
    }
    
    return totalSize;
}

@end











