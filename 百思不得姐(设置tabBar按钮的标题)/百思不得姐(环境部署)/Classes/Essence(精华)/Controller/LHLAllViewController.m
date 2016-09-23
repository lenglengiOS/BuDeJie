//
//  LHLAllViewController.m
//  百思不得姐(环境部署)
//
//  Created by admin on 16/9/19.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "LHLAllViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "LHLTopicsItem.h"
#import <MJExtension/MJExtension.h>
#import "LHLTopicsCell.h"

@interface LHLAllViewController ()

/** 请求管理者 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;
/** 当前最后一条帖子数据的描述信息，专门用来加载下一页数据 */
@property (nonatomic, copy) NSString *maxtime;
/** 所有的帖子数据 */
@property (nonatomic, strong) NSMutableArray *topics;
/** headerView */
@property (nonatomic, weak) UIView *headerView;
/** headerLabel */
@property (nonatomic, weak)  UILabel *headerLabel;
/** 记录是否正在下拉刷新 */
@property (nonatomic, assign, getter=isHeaderRefreshing) BOOL headerRefreshing;

/** footerView */
@property (nonatomic, weak) UIView *footerView;
/** footerLabel */
@property (nonatomic, weak)  UILabel *footerLabel;
/** 记录是否正在上拉加载 */
@property (nonatomic, assign, getter=isRefreshing) BOOL refreshing;

@end

@implementation LHLAllViewController

static NSString * const LHLTopicsCellID = @"LHLTopicsCell";

- (AFHTTPSessionManager *)manager{
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;

}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.tableView.contentInset = UIEdgeInsetsMake(LHLNavMaxY + LHLTitlesViewH, 0, LHLTabBarH, 0);
    self.view.backgroundColor = LHLColor(206, 206, 206);
    
    // 设置右边指示器的显示范围与tableView的内边距相同
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    // 注册cell
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([LHLTopicsCell class]) bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:LHLTopicsCellID];
    //去掉分割线
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    // 监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonDidRepeatClicked) name:LHLTabBarButtonRepeatClickedNotification object:nil];

    [self setUpRefesh];
    
}

/**
 *  tableFooterView拉刷新
 */
- (void)setUpRefesh{
    // header
    UIView *headerView = [[UIView alloc] init];
    headerView.frame = CGRectMake(0, -50, self.tableView.lhl_width, 50);
    headerView.backgroundColor = [UIColor redColor];
    self.headerView = headerView;
    
    UILabel *headerLabel = [[UILabel alloc] init];
    headerLabel.text =  @"下拉刷新";
    headerLabel.textAlignment = NSTextAlignmentCenter;
    headerLabel.textColor = [UIColor blackColor];
    headerLabel.backgroundColor = [UIColor grayColor];
    headerLabel.frame = headerView.bounds;
    headerLabel.font = [UIFont systemFontOfSize:15];
    self.headerLabel = headerLabel;
    [headerView addSubview:headerLabel];
    [self.tableView addSubview:headerView];
    
    // 广告
    UIView *adView = [[UIView alloc] init];
    adView.frame = CGRectMake(0, 0, 0, 30);
    adView.backgroundColor = [UIColor blackColor];
    self.tableView.tableHeaderView = adView;
    
    UILabel *adLabel = [[UILabel alloc] init];
    adLabel.text =  @"广告";
    adLabel.textAlignment = NSTextAlignmentCenter;
    adLabel.textColor = [UIColor whiteColor];
    adLabel.frame = self.tableView.tableHeaderView.bounds;
    adLabel.font = [UIFont systemFontOfSize:15];
    [adView addSubview:adLabel];
    
    // 让header自动刷新
    [self headerBeginRefreshing];
    
    // footer
    UIView *footerView = [[UIView alloc] init];
    footerView.frame = CGRectMake(0, 0, self.tableView.lhl_width, 35);
    footerView.backgroundColor = [UIColor redColor];
    self.footerView = footerView;
    self.tableView.tableFooterView = footerView;
    
    UILabel *footerLabel = [[UILabel alloc] init];
    footerLabel.text =  @"上拉或点击可以加载更多...";
    footerLabel.textAlignment = NSTextAlignmentCenter;
    footerLabel.textColor = [UIColor blackColor];
    footerLabel.backgroundColor = [UIColor grayColor];
    footerLabel.frame = self.tableView.tableFooterView.bounds;
    footerLabel.font = [UIFont systemFontOfSize:15];
    self.footerLabel = footerLabel;
    [footerView addSubview:footerLabel];
    
}

#pragma mark - 代理
/**
 *  拖拽结束就会调用这个方法
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{

    // 如果正在下拉刷新，则返回
    if (self.headerRefreshing == YES) return;
    CGFloat offsetY = - (self.tableView.contentInset.top + self.headerView.lhl_height);
    if (self.tableView.contentOffset.y <= offsetY) { // header已经完全出现
        // 开始刷新
        [self headerBeginRefreshing];
    }
}

/**
 *  滚动scrollView就会调用这个方法
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    // 处理header
    [self dealHeader];
    
    // 处理footer
    [self dealFooter];
 
}

/**
 *  处理header
 */
- (void)dealHeader{
    
    CGFloat offsetY = - (self.tableView.contentInset.top + self.headerView.lhl_height);
    
    // 如果正在下拉刷新，则返回
    if (self.headerRefreshing == YES) return;
    
    if (self.tableView.contentOffset.y <= offsetY) { // header已经完全出现
        
        // 如果偏移量超过offsetY 则显示 @"松开立即刷新"
        self.headerLabel.text = @"松开立即刷新";
    }else{
        
        // 如果偏移量小于offsetY，并且没有松开点击而是滑huiqu 则显示 @"下拉刷新"
        self.headerLabel.text =  @"下拉刷新";
    }
    
    
}

/**
 *  处理footer
 */
- (void)dealFooter{
 
    // 如果contentSize没有值，则返回
    if (self.tableView.contentSize.height == 0) return;
    CGFloat offstY = self.tableView.contentSize.height + self.tableView.contentInset.bottom - self.tableView.lhl_height;
    
    // 当scrollView的偏移量的y值 >= contentSize的高度 ＋ 底部内边距地高度 － tableView的高度
    if (self.tableView.contentOffset.y >= offstY && self.tableView.contentOffset.y > -(self.tableView.contentInset.top)) { // footer完全出现，并且使往上拖拽
        // 开始刷新
        [self footerBeginRefreshing];
        
    }

}

#pragma mark - 通知：LHLTabBarButtonRepeatClickedNotification
- (void)tabBarButtonDidRepeatClicked{
    
    // 如果LHLAllViewController所在的窗口不在控制器上，则返回
    if (self.view.window == nil) return;
    
    // 如果展示的不是LHLAllViewController，则返回
    if (self.tableView.scrollsToTop == NO) return;
    
    [self headerBeginRefreshing];
    LHLLog(@"%@ -- 刷新数据", self.class);
}

// 移除通知
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    self.footerView.hidden = (self.topics.count == 0);
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    // 10为图片，29为段子，31为音频，41为视频，默认为1
    LHLTopicsCell *cell = [tableView dequeueReusableCellWithIdentifier:LHLTopicsCellID];
    
    LHLTopicsItem *topic = self.topics[indexPath.row];
    cell.topic = topic;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 取出模型
    LHLTopicsItem *topic = self.topics[indexPath.row];
    CGFloat cellHeight = 0;
    // 正文的Y值
    cellHeight += 55;
    // 最大宽度
    CGSize textMaxSize = CGSizeMake(LHLScreenW - 2 * LHLMargin, MAXFLOAT);
    
    cellHeight += ([topic.text sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:textMaxSize].height + 2 * LHLMargin + 35);
    
    
    return cellHeight;
}

#pragma mark - 数据处理
/**
 *  发送请求给服务器－下拉刷新数据
 */
- (void)loadNewTopics{

    LHLLog(@"发送请求给服务器－下拉刷新数据");
    // 请求数据 ＝> 解析数据 ＝> 显示数据
    // 如果正在上拉加载，则取消下拉刷新的任务
    if (self.isRefreshing) {
        [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
        [self footerEndRefreshing];
    }
    
    // 拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"type"] = @"1";
    parameters[@"c"] = @"data";

    // 发送请求
    [self.manager GET:LHLCommonURL parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id _Nonnull responseObject) {

        // 把第一页的最后一条帖子数据的描述信息，专门用来加载下一页数据
        self.maxtime = responseObject[@"info"][@"maxtime"];
        self.topics = [LHLTopicsItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.tableView reloadData];
        // 结束刷新
        [self headerEndRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 结束刷新
        [self headerEndRefreshing];
        // 如果错误原因不是取消，才显示SVProgressHUD
        if (error.code != NSURLErrorCancelled) {
            [SVProgressHUD showErrorWithStatus:@"网络繁忙，请稍后再试！"];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    }];

}

/**
 *  发送请求给服务器－上拉刷新更多数据
 */
- (void)loadMoreTopics{

    LHLLog(@"发送请求给服务器－上拉刷新数据");
    self.footerLabel.text =  @"正在加载数据...";
    // 请求数据 ＝> 解析数据 ＝> 显示数据
    // 如果正在上拉加载，则取消下拉刷新的任务
    if (self.isHeaderRefreshing) {
        [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
        [self headerEndRefreshing];
    }
    // 拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"type"] = @"1";
    parameters[@"c"] = @"data";
    parameters[@"maxtime"] = self.maxtime;
    
    // 发送请求
    [self.manager GET:LHLCommonURL parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id _Nonnull responseObject) {
        
        // 当前页的最后一条帖子数据的描述信息，专门用来加载下一页数据
        self.maxtime = responseObject[@"info"][@"maxtime"];
        NSArray *topics = [LHLTopicsItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:topics];
        
        [self.tableView reloadData];
        // 结束刷新
        [self footerEndRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 结束刷新
        [self footerEndRefreshing];
        // 如果错误原因不是取消，才显示SVProgressHUD
        if (error.code != NSURLErrorCancelled) {
            [SVProgressHUD showErrorWithStatus:@"网络繁忙，请稍后再试！"];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    }];

}



#pragma mark - headerRefresh
- (void)headerBeginRefreshing{
    // 如果正在下拉刷新，则返回
    if (self.headerRefreshing == YES) return;
    
    self.headerLabel.text = @"正在刷新...";
    // 记录刷新状态为YES
    self.headerRefreshing = YES;
    
    // 增加tableView的top内边距，使刷新条显示在标题栏下
    [UIView animateWithDuration:0.25 animations:^{
        UIEdgeInsets inset = self.tableView.contentInset;
        inset.top += self.headerView.lhl_height;
        self.tableView.contentInset = inset;
        // 修改偏移量
        self.tableView.contentOffset = CGPointMake(self.tableView.contentOffset.x, -inset.top);
    }];
    
    [self loadNewTopics];
}

- (void)headerEndRefreshing{
    
    self.headerRefreshing = NO;
    [UIView animateWithDuration:0.4 animations:^{
        // 减小tableView的top内边距，使刷新条显示在标题栏后面，并清空刷新条的文字
        UIEdgeInsets inset = self.tableView.contentInset;
        inset.top -= self.headerView.lhl_height;
        self.tableView.contentInset = inset;
        // 显示数据
        LHLLog(@"刷新数据完成－显示数据");
    }];
}

#pragma mark - footerRefresh
- (void)footerBeginRefreshing{
    
    // 判断加载状态，如果正在上拉刷新，则返回
    if (self.refreshing == YES) return;
    self.refreshing = YES;
    // 发送请求给服务器
    [self loadMoreTopics];
}

- (void)footerEndRefreshing{
    self.refreshing = NO;
    [self.tableView reloadData];
    self.footerLabel.text =  @"上拉或点击可以加载更多...";
    LHLLog(@"刷新数据完成－显示数据");
}

@end
