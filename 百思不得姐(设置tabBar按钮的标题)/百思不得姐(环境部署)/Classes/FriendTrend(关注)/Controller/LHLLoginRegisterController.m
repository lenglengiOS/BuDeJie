//
//  LHLLoginRegisterController.m
//  百思不得姐(环境部署)
//
//  Created by admin on 16/9/16.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "LHLLoginRegisterController.h"

@interface LHLLoginRegisterController ()

@end

@implementation LHLLoginRegisterController

// 点击了取消按钮
- (IBAction)clickDissmissBtn:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 点击了注册按钮
- (IBAction)clickRegisterBtn:(UIButton *)sender {
    
    sender.selected = !sender.selected;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
