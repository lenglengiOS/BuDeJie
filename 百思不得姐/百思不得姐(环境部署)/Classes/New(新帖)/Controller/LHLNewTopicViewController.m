//
//  LHLNewTopicViewController.m
//  百思不得姐(环境部署)
//
//  Created by admin on 16/10/3.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "LHLNewTopicViewController.h"
#import "LHLSubTagController.h"
#import "LHLTopicsItem.h"

@interface LHLNewTopicViewController ()

@end

@implementation LHLNewTopicViewController

- (LHLTopicType)type{
    
    return LHLTopicTypeAll;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setUpNavBar];
    // 修改内边距
    UIEdgeInsets inset = self.tableView.contentInset;
    inset.top = 49;
    self.tableView.contentInset = inset;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonDidRepeatClicked) name:LHLTabBarButtonRepeatClickedNotification object:nil];
}

#pragma mark - LHLTabBarButtonRepeatClickedNotification
- (void)tabBarButtonDidRepeatClicked{
    
    // 如果LHLAllViewController所在的窗口不在控制器上，则返回
    if (self.view.window == nil) return;
    [super setUpRefesh];
    LHLLog(@"%@ -- 刷新数据", self.class);
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark 设置导航栏按钮
- (void)setUpNavBar{
    
    // 左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"MainTagSubIcon"] highImage:[UIImage imageNamed:@"MainTagSubIconClick"] target:self action:@selector(tagClick)];
    
    // 中间图片
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
}

- (void)tagClick{
    
    LHLSubTagController *subTagVc = [[LHLSubTagController alloc] init];
    [self.navigationController pushViewController:subTagVc animated:YES];
}

@end
