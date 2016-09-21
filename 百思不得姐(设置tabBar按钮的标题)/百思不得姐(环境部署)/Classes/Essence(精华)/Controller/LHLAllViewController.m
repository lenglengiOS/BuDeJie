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

/** footerView */
@property (nonatomic, weak) UIView *footerView;
/** footerLabel */
@property (nonatomic, weak)  UILabel *footerLabel;
/** 加载状态 */
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
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    // 判断加载状态，如果正在加载，则返回
    if (self.refreshing == YES) return;
    
    if (self.tableView.contentSize.height == 0) return;
    CGFloat offstY = self.tableView.contentSize.height + self.tableView.contentInset.bottom - self.tableView.lhl_height;
    if (self.tableView.contentOffset.y >= offstY) {
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
