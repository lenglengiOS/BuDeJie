//
//  LHLFriendTrendViewController.m
//  百思不得姐(环境部署)
//
//  Created by admin on 16/9/13.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "LHLFriendTrendViewController.h"
#import "LHLLoginRegisterController.h"

@interface LHLFriendTrendViewController ()

@end

@implementation LHLFriendTrendViewController
- (IBAction)loginRegisterClick:(id)sender {
    
    LHLLoginRegisterController *loginVc = [[LHLLoginRegisterController alloc] init];
    
    [self presentViewController:loginVc animated:YES completion:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor blueColor];
    [self setUpNavBar];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonDidRepeatClicked) name:LHLTabBarButtonRepeatClickedNotification object:nil];
    
    
}

#pragma mark - LHLTabBarButtonRepeatClickedNotification
- (void)tabBarButtonDidRepeatClicked{
    
    // 如果LHLAllViewController所在的窗口不在控制器上，则返回
    if (self.view.window == nil) return;
    
    LHLLog(@"%@ -- 刷新数据", self.class);
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark 设置导航栏按钮
- (void)setUpNavBar{
    
    // 左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"friendsRecommentIcon"] highImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] target:self action:@selector(friendsRecomment)];
    
    
    // 中间文字
    self.navigationItem.title = @"我的关注";
    
}

- (void)friendsRecomment{
    LHLFunc
}

@end



