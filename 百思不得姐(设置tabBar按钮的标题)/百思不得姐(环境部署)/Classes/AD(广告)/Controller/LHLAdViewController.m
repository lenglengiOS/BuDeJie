//
//  LHLAdViewController.m
//  百思不得姐(环境部署)
//
//  Created by admin on 16/9/15.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "LHLAdViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "LHLAdItem.h"
#import <MJExtension/MJExtension.h>
#import "UIImageView+WebCache.h"

#define code2 @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam"


@interface LHLAdViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *launchImageView;
@property (weak, nonatomic) IBOutlet UIView *adView;
@property (nonatomic, weak) UIImageView *adImage;
@property (nonatomic, strong) LHLAdItem *item;

@end

@implementation LHLAdViewController

- (UIImageView *)adImage{
    if (_adImage == nil) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        [self.adView addSubview:imageView];
        _adImage = imageView;
        _adImage.userInteractionEnabled = YES;
        
        // 添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        
        [_adImage addGestureRecognizer:tap];
        
    }
    return _adImage;
}

// 点击广告界面调用
- (void)tap{
    
    // 跳转到safari
    
    NSURL *url = [NSURL URLWithString:_item.ori_curl];
    UIApplication *app = [UIApplication sharedApplication];
    if ([app canOpenURL:url]) {
        [app openURL:url];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // 设置广告界面
    [self setUpLanuchImage];
    
    // 加载广告界面数据
    [self loadAddata];
    
}
/*
 
 http://mobads.baidu.com/cpro/ui/mads.php
 ?code2=phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam
 
 
 
 */

- (void)loadAddata{
    
    // 创建一个请求会话管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    // 拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"code2"] = code2;
    
    // 发送请求
    [mgr GET:@"http://mobads.baidu.com/cpro/ui/mads.php" parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nonnull responseObject) {
        
        // 获取字典
        NSDictionary *adDict = [responseObject[@"ad"] lastObject];
        // 字典转模型
        _item = [LHLAdItem mj_objectWithKeyValues:adDict];
        // 创建UIImageView显示图片
        CGFloat Height = LHLScreenW / _item.w * _item.h;
        
        self.adImage.frame = CGRectMake(0, 0, LHLScreenW, Height);
        
        // 加载广告网页
        [self.adImage sd_setImageWithURL:[NSURL URLWithString:_item.w_picurl]];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
    
    
}

- (void)setUpLanuchImage{
    
    // 判断手机的型号

    if (iphone6p) { // 6p
        
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x"];
    }else if (iphone6){ // 6
        
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-800-667h"];
    }else if (iphone5){ // 5
        
        
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-700-568h"];
    }else if (iphone4){ // 4
        
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-700"];
    }
    
}

/*
 LaunchImage@2x 4
 LaunchImage-568h@2x.png 5
 LaunchImage-800-667h@2x.png 6
 LaunchImage-800-Portrait-736h@3x.png 6p
 
 
 */

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
