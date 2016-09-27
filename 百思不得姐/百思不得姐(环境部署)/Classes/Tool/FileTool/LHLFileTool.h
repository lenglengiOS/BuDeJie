//
//  LHLFileTool.h
//  百思不得姐(环境部署)
//
//  Created by admin on 16/9/17.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LHLFileTool : NSObject
/**
 *  计算文件的大小
 *
 *  @param directoryPath 需要计算的文件夹的路径
 *
 *  @return 返回文件尺寸
 */
+ (void)getFileSize:(NSString *)directoryPath completion:(void(^)(NSInteger))completion;


/**
 *  删除系统缓存
 *
 *  @param directoryPath 需要删除的文件夹的路径
 */
+ (void)removeDirectoryPath:(NSString *)directoryPath;

@end
