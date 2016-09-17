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
    
    NSLog(@"www");
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    
   cell.textLabel.text = @"清除缓存";
    
//    NSInteger fileSize = [SDImageCache sharedImageCache].getSize;
//    NSLog(@"%ld", fileSize);
    
    // 获取Cachaes路径
    NSString *cachaePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    
    // 拼接default路径
    NSString *defaultPath = [cachaePath stringByAppendingPathComponent:@"default"];
    
    [self getFileSize:defaultPath];
    
    return cell;
}

- (void)getFileSize:(NSString *)directoryPath{
    
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
    
    LHLLog(@"%ld", totalSize);
    
    
    
}

@end











