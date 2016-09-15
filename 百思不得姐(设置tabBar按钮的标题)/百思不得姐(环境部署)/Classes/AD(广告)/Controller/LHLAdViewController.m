//
//  LHLAdViewController.m
//  百思不得姐(环境部署)
//
//  Created by admin on 16/9/15.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "LHLAdViewController.h"
#import <AFNetworking/AFNetworking.h>


@interface LHLAdViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *launchImageView;
@property (weak, nonatomic) IBOutlet UIView *adView;

@end

@implementation LHLAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpLanuchImage];
    
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
