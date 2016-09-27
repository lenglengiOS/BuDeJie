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

@interface LHLEssenceViewController ()<UIScrollViewDelegate>

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
    
    // 设置子控制器
    [self setUpChildVcs];
    
    // 设置导航栏按钮
    [self setUpNavBar];
    
    // ScrollView
    [self setUpScrollView];
    
    // 标题栏
    [self setUpTitlesView];
    
    // 初始化第0个控制器
    [self addChildViewIntoScrollView:0];
    
}

/**
 *  设置子控制器
 */
- (void)setUpChildVcs{
    
    LHLAllViewController *allVC = [[LHLAllViewController alloc] init];
    allVC.type = LHLTopicTypeAll;
    LHLVideoViewController *videoVC = [[LHLVideoViewController alloc] init];
    videoVC.type = LHLTopicTypeVideo;
    LHLVoiceViewController *voiceVC = [[LHLVoiceViewController alloc] init];
    voiceVC.type = LHLTopicTypeVoice;
    LHLPictureViewController *pictureVC = [[LHLPictureViewController alloc] init];
    pictureVC.type = LHLTopicTypePicture;
    LHLWordViewController *wordVC = [[LHLWordViewController alloc] init];
    wordVC.type = LHLTopicTypeWord;
    
    [self addChildViewController:allVC];
    [self addChildViewController:videoVC];
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
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    NSInteger count = self.childViewControllers.count;
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    
    scrollView.backgroundColor = [UIColor blueColor];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    scrollView.scrollsToTop = NO;
    
    scrollView.contentSize = CGSizeMake(count * LHLScreenW, LHLScreenH);
    scrollView.lhl_x = 0;
    scrollView.delegate = self;
    self.scrollView = scrollView;
    
    [self.view addSubview:scrollView];
    
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
        titleButton.tag = i;
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
    
    // 让label根据文字计算尺寸
    [firstTitleBtn.titleLabel sizeToFit];
    
    // 默认点击第一个按钮
    firstTitleBtn.selected = YES;
    self.previousClickTitleBtn = firstTitleBtn;
    
    // 处理下划线
    self.titleUnderLine.lhl_width = firstTitleBtn.titleLabel.lhl_width + 10;
    self.titleUnderLine.lhl_centerX = firstTitleBtn.lhl_centerX;


 
}


#pragma mark - 监听
/**
 *  点击了titleView里面的按钮
 */
- (void)titleBtnClick:(LHLTitleButton *)button{
    
    // 重复点击了标题按钮
    if (self.previousClickTitleBtn == button) {
        [[NSNotificationCenter defaultCenter] postNotificationName:LHLTabBarButtonRepeatClickedNotification object:nil];
    }
    
    // 处理标题按钮的点击
    [self dealTitleButtonClick:button];
    
}

- (void)dealTitleButtonClick:(LHLTitleButton *)button
{
    self.previousClickTitleBtn.selected = NO;
    button.selected = YES;
    self.previousClickTitleBtn = button;
    
    NSUInteger index = button.tag;
    // 处理下划线
    [UIView animateWithDuration:0.25 animations:^{
        
        self.titleUnderLine.lhl_width = button.titleLabel.lhl_width + 10;
        self.titleUnderLine.lhl_centerX = button.lhl_centerX;
        
        CGPoint offset = self.scrollView.contentOffset;
        offset.x = index * LHLScreenW;
        self.scrollView.contentOffset = offset;
        
    }completion:^(BOOL finished) {
        
        [self addChildViewIntoScrollView:index];
    }];
    
    // 设置index位置对应的tableView.scrollsToTOp = YES, 其他都设置为NO
    for(int i = 0; i < self.childViewControllers.count; i++){
        
        UIViewController *childVc = self.childViewControllers[i];
        if (!childVc.isViewLoaded) continue;
        
        UIScrollView *scrolView = (UIScrollView *)childVc.view;
        if (![scrolView isKindOfClass:[UIScrollView class]]) continue;
        
        scrolView.scrollsToTop = (i == index);
        
    }
}

/**
 *  点击了游戏按钮
 */
- (void)game{

    LHLFunc
}

#pragma mark - 代理方法

/**
 *  UIScrollView
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger index = scrollView.contentOffset.x / LHLScreenW;
    
    LHLTitleButton *titleBtn = self.titlesView.subviews[index];
//    [self titleBtnClick:titleBtn];
    [self dealTitleButtonClick:titleBtn];
    
}

#pragma mark - 其他
/**
 *  添加第index个控制器的view到scrollView中
 */
- (void)addChildViewIntoScrollView:(NSUInteger)index{
    
    UIView *childView = self.childViewControllers[index].view;
    childView.frame = CGRectMake(index * LHLScreenW, 0, LHLScreenW, LHLScreenH);
    if(childView.superview) return;
    [self.scrollView addSubview:childView];
}

@end
