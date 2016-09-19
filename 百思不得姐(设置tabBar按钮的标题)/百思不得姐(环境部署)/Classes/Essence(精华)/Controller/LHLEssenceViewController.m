//
//  LHLEssenceViewController.m
//  百思不得姐(环境部署)
//
//  Created by admin on 16/9/13.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "LHLEssenceViewController.h"
#import "LHLTitleButton.h"
#import "LHLAllViewController.h"
#import "LHLVideoViewController.h"
#import "LHLVoiceViewController.h"
#import "LHLPictureViewController.h"
#import "LHLWordViewController.h"

@interface LHLEssenceViewController ()

@property (nonatomic, weak) UIView *titlesView;
@property (nonatomic, weak) LHLTitleButton *previousClickTitleBtn;
/** 下划线 */
@property (nonatomic, weak) UIView *titleUnderLine;
/** scrollView */
@property (nonatomic, weak) UIScrollView *scrollView;

@end

@implementation LHLEssenceViewController

#pragma mark - 初始化

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor blueColor];
    
    [self setUpChildVcs];
    
    [self setUpNavBar];
    
    [self setUpScrollView];
    
    [self setUpTitlesView];
    
}

/**
 *  设置子控制器
 */
- (void)setUpChildVcs{
    
    LHLAllViewController *allVC = [[LHLAllViewController alloc] init];
    LHLVideoViewController *viedeoVC = [[LHLVideoViewController alloc] init];
    LHLVoiceViewController *voiceVC = [[LHLVoiceViewController alloc] init];
    LHLPictureViewController *pictureVC = [[LHLPictureViewController alloc] init];
    LHLWordViewController *wordVC = [[LHLWordViewController alloc] init];
    
    [self addChildViewController:allVC];
    [self addChildViewController:viedeoVC];
    [self addChildViewController:voiceVC];
    [self addChildViewController:pictureVC];
    [self addChildViewController:wordVC];
    
    
}

/**
 *  设置导航栏按钮
 */
- (void)setUpNavBar{
    
    // 左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"nav_item_game_icon"] highImage:[UIImage imageNamed:@"nav_item_game_click_icon"] target:self action:@selector(game)];
    
    
    // 右边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navigationButtonRandom"] highImage:[UIImage imageNamed:@"navigationButtonRandomClick"] target:nil action:nil];
    
    
    // 中间图片
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
}

/**
 *  ScrollView
 */
- (void)setUpScrollView{
    
    NSInteger count = self.childViewControllers.count;
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    
    scrollView.backgroundColor = [UIColor blueColor];
    _scrollView = scrollView;
    _scrollView.contentSize = CGSizeMake(count * LHLScreenW, LHLScreenH);
    [self.view addSubview:scrollView];
    
    CGFloat scrollViewW = _scrollView.lhl_width;
    
    for(int i = 0; i < count; i++){
        UIView *childView = self.childViewControllers[i].view;
        childView.lhl_x = i * scrollViewW;
        [self.scrollView addSubview:childView];
        
    }

    
    
    
    
}
/**
 *  标题栏
 */
- (void)setUpTitlesView{
    
    UIView *titlesView = [[UIView alloc] init];
    titlesView.frame = CGRectMake(0, 64, self.view.lhl_width, 35);
    _titlesView = titlesView;
    
    // 设置标题栏透明色
    titlesView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    [self.view addSubview:titlesView];
    
    [self setUpTitleButtons];
    
    [self setUpUnderLines];
    
}


/**
 *  标题栏按钮
 */
- (void)setUpTitleButtons{
    
    NSArray *buttonLabels = @[@"全部", @"视频", @"声音", @"图片", @"段子"];
    NSInteger count = buttonLabels.count;
    
    CGFloat buttonW = self.titlesView.lhl_width / count;
    CGFloat buttonH = self.titlesView.lhl_height;
    
    for(int i = 0; i < count; i++){
        
        LHLTitleButton *titleButton = [LHLTitleButton buttonWithType:UIButtonTypeCustom];
        titleButton.frame = CGRectMake(i * buttonW, 0, buttonW, buttonH);
        [titleButton setTitle:buttonLabels[i] forState:UIControlStateNormal];
        
        // 监听
        [titleButton addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [self.titlesView addSubview:titleButton];
        
    }
    
}


/**
 *  下划线
 */
- (void)setUpUnderLines{
    
    // 取出titlesView中的button
    LHLTitleButton *firstTitleBtn = self.titlesView.subviews.firstObject;
    
    UIView *titleUnderLine = [[UIView alloc]init];
    titleUnderLine.lhl_height = 2;
    titleUnderLine.lhl_centerY = self.titlesView.lhl_height - titleUnderLine.lhl_height;
    titleUnderLine.backgroundColor = [firstTitleBtn titleColorForState:UIControlStateSelected];
    [self.titlesView addSubview:titleUnderLine];
    _titleUnderLine = titleUnderLine;
    
    // 默认点击第一个按钮
    [firstTitleBtn.titleLabel sizeToFit];
    
    // 处理下划线
    self.titleUnderLine.lhl_width = firstTitleBtn.titleLabel.lhl_width + 10;
    self.titleUnderLine.lhl_centerX = firstTitleBtn.lhl_centerX;


 
}


#pragma mark - 监听

- (void)titleBtnClick:(LHLTitleButton *)button{
    
    self.previousClickTitleBtn.selected = NO;
    button.selected = YES;
    self.previousClickTitleBtn = button;

    // 处理下划线
    [UIView animateWithDuration:0.25 animations:^{
        
        self.titleUnderLine.lhl_width = button.titleLabel.lhl_width + 10;
        self.titleUnderLine.lhl_centerX = button.lhl_centerX;
        
    }];
    
}



- (void)game{

    LHLFunc
}





@end
