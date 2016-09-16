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
#import <SVProgressHUD/SVProgressHUD.h>


static NSString * const ID = @"cell";

@interface LHLSubTagController ()

@property (nonatomic, strong) NSArray *subTags;
@property (nonatomic, weak)  AFHTTPSessionManager *mgr;

@end


@implementation LHLSubTagController

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    // 销毁指示器
    [SVProgressHUD dismiss];
    
    // 取消之前的请求
    [_mgr.tasks makeObjectsPerformSelector:@selector(cancel)];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 请求数据 ＝> 解析数据 ＝> 显示数据
    
    // 创建请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    _mgr = mgr;
    // 拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"tag_recommend";
    parameters[@"action"] = @"sub";
    parameters[@"c"] = @"topic";
    
    [SVProgressHUD showWithStatus:@"正在努力加载中..."];
    
    // 发送请求
    [_mgr GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, NSArray *  _Nonnull responseObject) {
        
        self.subTags = [LHLSubTagItem mj_objectArrayWithKeyValuesArray:responseObject];
        
        // 刷新表格
        [self.tableView reloadData];
        
        [SVProgressHUD dismiss];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
    }];

    
    
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"LHLSubTagCell" bundle:nil] forCellReuseIdentifier:ID];
    
    self.title = @"推荐标签";
    
    
    // 去除多余的线
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    // 1.取消系统自带的分割线  2.设置tabVlew的背景色为分割线的背景色 3.拦截setFrame方法，把cell的高度减1
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:220 / 256.0 green:220 / 256.0 blue:221 / 256.0 alpha:1];

    
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
