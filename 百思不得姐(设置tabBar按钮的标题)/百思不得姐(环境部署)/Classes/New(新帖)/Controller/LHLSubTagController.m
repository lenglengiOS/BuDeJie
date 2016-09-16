//
//  LHLSubTagController.m
//  百思不得姐(环境部署)
//
//  Created by admin on 16/9/15.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "LHLSubTagController.h"
#import <MJExtension/MJExtension.h>
#import <AFNetworking/AFNetworking.h>
#import "LHLSubTagItem.h"
#import "LHLSubTagCell.h"

static NSString * const ID = @"cell";

@interface LHLSubTagController ()

@property (nonatomic, strong) NSArray *subTags;

@end


@implementation LHLSubTagController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 请求数据 ＝> 解析数据 ＝> 显示数据
    
    // 创建请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    // 拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"tag_recommend";
    parameters[@"action"] = @"sub";
    parameters[@"c"] = @"topic";
    
    // 发送请求
    [mgr GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, NSArray *  _Nonnull responseObject) {
        
        self.subTags = [LHLSubTagItem mj_objectArrayWithKeyValuesArray:responseObject];
        
        // 刷新表格
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"LHLSubTagCell" bundle:nil] forCellReuseIdentifier:ID];
    
    self.title = @"推荐标签";
    
    
    // 处理分割线，清空tableView的内边距，清空cell的约束边缘
    self.tableView.separatorInset = UIEdgeInsetsZero;

    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.subTags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 自定义cell
    LHLSubTagCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    
    
    // 取出模型
    LHLSubTagItem *item = self.subTags[indexPath.row];
    cell.item = item;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}




@end
