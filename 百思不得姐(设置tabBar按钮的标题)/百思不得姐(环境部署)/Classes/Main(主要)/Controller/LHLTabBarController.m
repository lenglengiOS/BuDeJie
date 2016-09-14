//
//  LHLTabBarController.m
//  百思不得姐(环境部署)
//
//  Created by admin on 16/9/13.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "LHLTabBarController.h"
#import "LHLEssenceViewController.h"
#import "LHLFriendTrendViewController.h"
#import "LHLMeTableViewController.h"
#import "LHLNewViewController.h"
#import "LHLPublishViewController.h"
#import "LHLTabBar.h"

#import "UIImage+image.h"

@interface LHLTabBarController ()

@end

@implementation LHLTabBarController

+ (void)load{
    
    // 设置UITabBarItem按钮的颜色: appearanceWhenContainedIn
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    [item setTitleTextAttributes:attrs forState:UIControlStateSelected];
    
    // 设置字体的尺寸(只有正常状态下设置才有效果)
    NSMutableDictionary *attrsNor = [NSMutableDictionary dictionary];
    attrsNor[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:attrsNor forState:UIControlStateNormal];
    
}

#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 创建所有子控制器
    [self setUpAllChildViewController];
    
    // 设置所有子控制器的标题
    [self setUpAllTitleButton];
    
    // 自定义tabBar
    [self setUpTabBar];
    
}

- (void)setUpTabBar{
    
    LHLTabBar *tabBar = [[LHLTabBar alloc] init];
    [self setValue:tabBar forKeyPath:@"tabBar"];
    

    
}

#pragma mark - 创建所有子控制器
- (void)setUpAllChildViewController{
    // 1.精华
    LHLEssenceViewController *essenceVC = [[LHLEssenceViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:essenceVC];
    [self addChildViewController:nav];
    
    
    // 2.新帖
    LHLNewViewController *newVC = [[LHLNewViewController alloc] init];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:newVC];
    [self addChildViewController:nav1];
    
//    // 3.发布
//    LHLPublishViewController *publishVC = [[LHLPublishViewController alloc] init];
//    [self addChildViewController:publishVC];
    
    
    // 4.关注
    LHLFriendTrendViewController *friendVC = [[LHLFriendTrendViewController alloc] init];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:friendVC];
    [self addChildViewController:nav3];
    
    // 5.我
    LHLMeTableViewController *meVC = [[LHLMeTableViewController alloc] init];
    UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:meVC];
    [self addChildViewController:nav4];
}


#pragma mark - 设置所有子控制器的标题
- (void)setUpAllTitleButton{
    // 设置tabBar内容 -> 由对应子控制器的tabBatItem属性确定
    // nav
    UINavigationController *nav = self.childViewControllers[0];
    nav.tabBarItem.title = @"精华";
    nav.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    nav.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_essence_click_icon"];

    // 新帖
    UINavigationController *nav1 = self.childViewControllers[1];
    nav1.tabBarItem.title = @"新帖";
    nav1.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
    nav1.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_new_click_icon"];
    
    // 发布
//    LHLPublishViewController *publishVC = self.childViewControllers[2];
//    publishVC.tabBarItem.image = [UIImage imageOriginalWithName:@"tabBar_publish_icon"];
//    publishVC.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_publish_click_icon"];
//    // 设置图片的位置
//    publishVC.tabBarItem.imageInsets = UIEdgeInsetsMake(7, 0, -7, 0);
    
    // 关注
    UINavigationController *nav3 = self.childViewControllers[2];
    nav3.tabBarItem.title = @"关注";
    nav3.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    nav3.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_friendTrends_click_icon"];
    
    
    // 我
    UINavigationController *nav4 = self.childViewControllers[3];
    nav4.tabBarItem.title = @"我";
    nav4.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    nav4.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_me_click_icon"];
}





@end
