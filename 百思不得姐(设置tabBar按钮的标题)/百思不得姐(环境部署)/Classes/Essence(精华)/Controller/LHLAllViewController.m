//
//  LHLAllViewController.m
//  百思不得姐(环境部署)
//
//  Created by admin on 16/9/19.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "LHLAllViewController.h"


@interface LHLAllViewController ()
/** headerView */
@property (nonatomic, weak) UIView *headerView;
/** headerLabel */
@property (nonatomic, weak)  UILabel *headerLabel;
/** 记录是否正在刷新 */
@property (nonatomic, assign, getter=isHeaderRefreshing) BOOL headerRefreshing;

/** footerView */
@property (nonatomic, weak) UIView *footerView;
/** footerLabel */
@property (nonatomic, weak)  UILabel *footerLabel;
/** 记录是否正在加载 */
@property (nonatomic, assign, getter=isRefreshing) BOOL refreshing;
/** 数据量 */
@property (nonatomic, assign) NSInteger dataCount;

@end

@implementation LHLAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataCount = 20;
    
    self.tableView.contentInset = UIEdgeInsetsMake(LHLNavMaxY + LHLTitlesViewH, 0, LHLTabBarH, 0);
    self.view.backgroundColor = LHLRandomColor;
    
    // 设置右边指示器的显示范围与tableView的内边距相同
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
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

    // 如果正在刷新，则返回
    if (self.headerRefreshing == YES) return;
    
    CGFloat offsetY = - (self.tableView.contentInset.top + self.headerView.lhl_height);
    
    if (self.tableView.contentOffset.y <= offsetY) { // header已经完全出现
        self.headerLabel.text = @"正在刷新...";
        // 记录刷新状态为YES
        self.headerRefreshing = YES;
        
        // 增加tableView的top内边距，使刷新条显示在标题栏下
        [UIView animateWithDuration:0.25 animations:^{
            UIEdgeInsets inset = self.tableView.contentInset;
            inset.top += self.headerView.lhl_height;
            self.tableView.contentInset = inset;
        }];
        
        LHLLog(@"发送请求给服务器－下拉刷新数据");
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            // 服务器的数据回来了 刷新数据
            self.dataCount = 20;
            [self.tableView reloadData];
            // 改变刷新状态为NO
            self.headerRefreshing = NO;
            [UIView animateWithDuration:0.4 animations:^{
                
                // 减小tableView的top内边距，使刷新条显示在标题栏后面，并清空刷新条的文字
                UIEdgeInsets inset = self.tableView.contentInset;
                inset.top -= self.headerView.lhl_height;
                self.tableView.contentInset = inset;
           
                // 显示数据
                LHLLog(@"刷新数据完成－显示数据");
            }];
        });
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
    
    // 如果正在刷新，则返回
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
    // 判断加载状态，如果正在加载，则返回
    if (self.refreshing == YES) return;
    
    // 如果contentSize没有值，则返回
    if (self.tableView.contentSize.height == 0) return;
    CGFloat offstY = self.tableView.contentSize.height + self.tableView.contentInset.bottom - self.tableView.lhl_height;
    
    // 当scrollView的偏移量的y值 >= contentSize的高度 ＋ 底部内边距地高度 － tableView的高度
    if (self.tableView.contentOffset.y >= offstY) {
        // 开始加载
        self.refreshing = YES;
        
        // 发送请求给服务器
        self.footerLabel.text =  @"正在加载数据...";
        
        // 模拟请求数据成功
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            // 结束刷新
            self.refreshing = NO;
            self.dataCount += 5;
            self.footerLabel.text =  @"上拉或点击可以加载更多...";
            [self.tableView reloadData];
            
        });
        
    }

}

#pragma mark - 通知：LHLTabBarButtonRepeatClickedNotification
- (void)tabBarButtonDidRepeatClicked{
    
    // 如果LHLAllViewController所在的窗口不在控制器上，则返回
    if (self.view.window == nil) return;
    
    // 如果展示的不是LHLAllViewController，则返回
    if (self.tableView.scrollsToTop == NO) return;
    
    LHLLog(@"%@ -- 刷新数据", self.class);
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    self.footerView.hidden = (self.dataCount == 0);
    return self.dataCount;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor clearColor];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %ld", self.class, indexPath.row];
    
    return cell;
}



@end
