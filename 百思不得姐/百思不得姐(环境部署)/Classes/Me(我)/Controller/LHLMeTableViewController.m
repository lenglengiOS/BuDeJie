//
//  LHLMeTableViewController.m
//  百思不得姐(环境部署)
//
//  Created by admin on 16/9/13.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "LHLMeTableViewController.h"
#import "LHLSettingViewController.h"
#import "LHLSquareCell.h"
#import <AFNetworking/AFNetworking.h>
#import "LHLSquarItem.h"
#import <MJExtension/MJExtension.h>
#import <SafariServices/SafariServices.h>
#import "LHLWebViewController.h"

static NSString * const ID = @"cell";
static NSInteger cols = 4;
static CGFloat margin = 1;
#define cellWH (LHLScreenW - (cols - 1) * margin) / cols

@interface LHLMeTableViewController ()<UICollectionViewDataSource,UICollectionViewDelegate, SFSafariViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *squareItems;
@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation LHLMeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNavBar];
    
    [self setUpFootView];
    
    [self reloadData];
    
    // 处理cell间距，默认tableView有顶部间距和底部间距
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    
    self.collectionView.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonDidRepeatClicked) name:LHLTabBarButtonRepeatClickedNotification object:nil];
    
    
}

#pragma mark - LHLTabBarButtonRepeatClickedNotification
- (void)tabBarButtonDidRepeatClicked{
    
    // 如果LHLAllViewController所在的窗口不在控制器上，则返回
    if (self.view.window == nil) return;
    LHLLog(@"%@ -- 刷新数据", self.class);
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    /*
    LHLSquarItem *item = self.squareItems[indexPath.row];
    if (![item.url containsString:@"http"]) return;
    
    SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:item.url]];
    safariVC.delegate = self;
    [self presentViewController:safariVC animated:YES completion:nil];
    */
    LHLSquarItem *item = self.squareItems[indexPath.row];
    LHLWebViewController *webView = [[LHLWebViewController alloc]init];
    webView.url = item.url;
    if (![webView.url containsString:@"http"])return;
    
    [self.navigationController pushViewController:webView animated:YES];
    
    
}

#pragma mark - SFSafariViewController
/*
- (void)safariViewControllerDidFinish:(SFSafariViewController *)controller{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
 */


// 加载数据
- (void)reloadData{
    // 请求数据
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"square";
    parameters[@"c"] = @"topic";
    
    
    [mgr GET:LHLCommonURL parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nonnull responseObject) {
        
        NSArray *dataArr = responseObject[@"square_list"];
        self.squareItems = [LHLSquarItem mj_objectArrayWithKeyValuesArray:dataArr];
        
        // 设置collectionView高度
        NSInteger rows = (self.squareItems.count - 1) / cols + 1; // 行数
        _collectionView.lhl_height = cellWH * rows + 10;
        
        self.tableView.tableFooterView = self.collectionView;
        
        [self resolveData];
        
        // 刷新数据！！！！！！！！！！！！！！！！！！！！！！！！
        [self.collectionView reloadData];
  
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

#pragma mark - 处理数据 ，补齐
- (void)resolveData{
    
    NSInteger count =  cols - self.squareItems.count % cols; // 每行差几个补齐
    
    if (count) {
        for(int i = 0; i < count; i++){
            
            LHLSquarItem *item = [[LHLSquarItem alloc] init];
            [self.squareItems addObject:item];
            
        }
        
    }
    
}

// 设置footerView
- (void)setUpFootView{
    // 1.设置流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
   
    layout.itemSize = CGSizeMake(cellWH, cellWH);
    layout.minimumInteritemSpacing = margin;
    layout.minimumLineSpacing = margin;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 300) collectionViewLayout:layout];
    _collectionView = collectionView;
    
    collectionView.backgroundColor = self.tableView.backgroundColor;
    collectionView.scrollEnabled = NO;
    collectionView.dataSource = self;
    
    // 2.注册cell
    [collectionView registerNib:[UINib nibWithNibName:@"LHLSquareCell" bundle:nil] forCellWithReuseIdentifier:ID];
  
    // 3.自定义cell
    self.tableView.tableFooterView = collectionView;
    
}

#pragma mark - UICollectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.squareItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    // 从缓存池取
    LHLSquareCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    LHLSquarItem *item = self.squareItems[indexPath.item];
    cell.backgroundColor = [UIColor whiteColor];
    
    cell.item = item;
    
    return cell;
    
}



#pragma mark 设置导航栏按钮
- (void)setUpNavBar{
    
    // 设置按钮
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-setting-icon"] highImage:[UIImage imageNamed:@"mine-setting-icon-click"] target:self action:@selector(setting)];
    
    // 夜间模式
    UIBarButtonItem *nightItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-moon-icon"] selImage:[UIImage imageNamed:@"mine-moon-icon-click"] target:self action:@selector(night:)];
    
    self.navigationItem.rightBarButtonItems = @[settingItem, nightItem];
    
    // 中间文字
    self.navigationItem.title = @"我的";
    
}

- (void)setting{
    
    LHLSettingViewController *settingVC = [[LHLSettingViewController alloc] init];
    [self.navigationController pushViewController:settingVC animated:YES];
    
}

- (void)night:(UIButton *)button{
    LHLFunc
    button.selected = !button.selected;
}

@end
