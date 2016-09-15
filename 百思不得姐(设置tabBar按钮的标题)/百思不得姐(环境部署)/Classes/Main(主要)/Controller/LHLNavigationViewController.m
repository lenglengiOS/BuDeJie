//
//  LHLNavigationViewController.m
//  百思不得姐(环境部署)
//
//  Created by admin on 16/9/15.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "LHLNavigationViewController.h"

@interface LHLNavigationViewController ()

@end

@implementation LHLNavigationViewController

+ (void)load{
    
    
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    
    
    // 设置字体
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    [navBar setTitleTextAttributes:attr];
    
    // 设置导航条背景图片
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];

    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];


    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    
    if (self.childViewControllers.count > 0) { // 非根控制器
        
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navigationButtonReturn"] highImage:[UIImage imageNamed:@"navigationButtonReturnClick"] target:self action:@selector(back) title:@"返回"];
    }
    
    [super pushViewController:viewController animated:animated];
    
    
}

- (void)back{
    [self popViewControllerAnimated:YES];
}


@end
