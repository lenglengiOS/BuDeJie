//
//  LHLLoginRegisterController.m
//  百思不得姐(环境部署)
//
//  Created by admin on 16/9/16.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "LHLLoginRegisterController.h"
#import "LHLLoginRegisterView.h"
#import "LHLFastLoginView.h"

@interface LHLLoginRegisterController ()

// 中间视图
@property (weak, nonatomic) IBOutlet UIView *loadRegisterView;
/**
 *  左边的约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadConst;

// 底部视图
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation LHLLoginRegisterController

// 点击了取消按钮
- (IBAction)clickDissmissBtn:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 点击了注册按钮
- (IBAction)clickRegisterBtn:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    _leadConst.constant = _leadConst.constant == 0?-_loadRegisterView.frame.size.width * 0.5:0;
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 从xib加载完视图后，需要重新设置一下尺寸，但不是在viewDidLoad中，而是在viewDidLayoutSubviews去布局子控件

    // 加载中间视图
    LHLLoginRegisterView *loginVC = [LHLLoginRegisterView loadView];
    
    [self.loadRegisterView addSubview:loginVC];
    
    LHLLoginRegisterView *registerVc = [LHLLoginRegisterView registerView];
    
    [self.loadRegisterView addSubview:registerVc];
    
    // 加载底部视图
    LHLFastLoginView *fastView = [LHLFastLoginView fastLoginView];
    [self.bottomView addSubview:fastView];
    
    
}

// 在这里布局子控件
- (void)viewDidLayoutSubviews{
    LHLLoginRegisterView *loginVC = self.loadRegisterView.subviews[0];
    loginVC.frame = CGRectMake(0, 0, self.loadRegisterView.lhl_width * 0.5, self.loadRegisterView.lhl_height);
    
    LHLLoginRegisterView *registerVc = self.loadRegisterView.subviews[1];
    registerVc.frame = CGRectMake(self.loadRegisterView.lhl_width * 0.5, 0, self.loadRegisterView.lhl_width * 0.5, self.loadRegisterView.lhl_height);
    LHLFastLoginView *fastView = self.bottomView.subviews[0];
    fastView.frame = self.bottomView.bounds;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
