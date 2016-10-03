//
//  LHLFileTool.m
//  百思不得姐(环境部署)
//
//  Created by admin on 16/9/17.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "LHLFileTool.h"

@implementation LHLFileTool


// 计算文件的大小
+ (void)getFileSize:(NSString *)directoryPath completion:(void(^)(NSInteger))completion{
    
    // 获取文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    BOOL isDirectory;
    BOOL isExist = [mgr fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    
    if (!isExist || !isDirectory) {
        NSException *excp = [NSException exceptionWithName:@"pathError" reason:@"需要穿入文件夹" userInfo:nil];
        [excp raise];
    }
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
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
        
        // 计算完成回调
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (completion) {
                completion(totalSize);
            }
        });
        
        
        
    });
    
    

}

// 删除系统缓存
+ (void)removeDirectoryPath:(NSString *)directoryPath{
    
    // 获取文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    BOOL isDirectory;
    BOOL isExist = [mgr fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    
    if (!isExist || !isDirectory) {
        NSException *excp = [NSException exceptionWithName:@"pathError" reason:@"需要传入文件夹" userInfo:nil];
        [excp raise];
    }
    
    // 获取caches文件夹下所有文件，不包括子路径的子路径
    NSArray *subPaths = [mgr contentsOfDirectoryAtPath:directoryPath error:nil];
    
    for (NSString *subPath in subPaths) {
        
        NSString *path = [directoryPath stringByAppendingPathComponent:subPath];
        [mgr removeItemAtPath:path error:nil];
        
    }
    
}

@end
