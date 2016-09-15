//
//  LHLNavigationViewController.m
//  百思不得姐(环境部署)
//
//  Created by admin on 16/9/15.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "LHLNavigationViewController.h"

@interface LHLNavigationViewController ()<UIGestureRecognizerDelegate>

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
    
    
//    self.interactivePopGestureRecognizer.delegate = self;
//    NSLog(@"%@", self.interactivePopGestureRecognizer);
    
    // initWithTarget:self.interactivePopGestureRecognizer.delegate 利用系统的滑动功能
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]
                                   initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    [self.view addGestureRecognizer:pan];
    
    // 控制手势什么时候出发，只有是非根控制器的时候才触发
    pan.delegate = self;
    
    // 禁止之前的手势
    self.interactivePopGestureRecognizer.enabled = NO;
    
    
}

/*
 
 <UIScreenEdgePanGestureRecognizer: 0x7fe5f0f77790; state = Possible; delaysTouchesBegan = YES; view = <UILayoutContainerView 0x7fe5f0d28b90>; target= <(action=handleNavigationTransition:, target=<_UINavigationInteractiveTransition 0x7fe5f0f771e0>)>>
 
 */


#pragma mark - UIGestureRecognizerDelegate

// 判断是否设置滑动返回，只有是非根控制器的时候才触发
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    // 非根控制器
    return self.childViewControllers.count > 1;
    
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    
    if (self.childViewControllers.count > 0) { // 非根控制器
        
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navigationButtonReturn"] highImage:[UIImage imageNamed:@"navigationButtonReturnClick"] target:self action:@selector(back) title:@"返回"];
        
        // push 后隐藏BottomBar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
    
    
}

- (void)back{
    
    [self popViewControllerAnimated:YES];
}


@end
