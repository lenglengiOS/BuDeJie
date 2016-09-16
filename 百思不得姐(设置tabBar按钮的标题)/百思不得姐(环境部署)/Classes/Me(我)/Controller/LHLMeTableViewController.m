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

static NSString * const ID = @"cell";

@interface LHLMeTableViewController ()<UICollectionViewDataSource>

@property (nonatomic, strong) NSArray *squareItems;
@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation LHLMeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNavBar];
    
    [self setUpFootView];
    
    [self reloadData];
    
}

// 加载数据
- (void)reloadData{
    // 请求数据
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"square";
    parameters[@"c"] = @"topic";
    
    
    [mgr GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nonnull responseObject) {
        
        NSArray *dataArr = responseObject[@"square_list"];
        self.squareItems = [LHLSquarItem mj_objectArrayWithKeyValuesArray:dataArr];
        
        // 刷新数据！！！！！！！！！！！！！！！！！！！！！！！！
        [self.collectionView reloadData];
  
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

// 设置footerView
- (void)setUpFootView{
    // 1.设置流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    NSInteger cols = 4; // 4列
    CGFloat margin = 1; // 间距
    CGFloat cellWH = (LHLScreenW - (cols - 1) * margin) / cols; // cell的宽高
    layout.itemSize = CGSizeMake(cellWH, cellWH);
    layout.minimumInteritemSpacing = margin;
    layout.minimumLineSpacing = margin;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 300) collectionViewLayout:layout];
    _collectionView = collectionView;
    
    collectionView.backgroundColor = self.tableView.backgroundColor;
    
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
    
    LHLLog(@"%p", cell);
    
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
