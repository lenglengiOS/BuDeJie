//
//  LHLSeeBigPictureViewController.m
//  百思不得姐(环境部署)
//
//  Created by admin on 16/9/26.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "LHLSeeBigPictureViewController.h"
#import "LHLTopicsItem.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <Photos/Photos.h>

@interface LHLSeeBigPictureViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (nonatomic, weak) UIImageView *imageView;
- (PHAssetCollection *)createdCollection;
@end

@implementation LHLSeeBigPictureViewController

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];

    // scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = [UIScreen mainScreen].bounds;
    [self.view insertSubview:scrollView atIndex:0];
    
    // imageView
    UIImageView *imageView = [[UIImageView alloc] init];
    self.imageView = imageView;
    imageView.lhl_width = scrollView.lhl_width;
    imageView.lhl_height = self.topic.height * imageView.lhl_width / self.topic.width;
    imageView.lhl_x = 0;
    imageView.lhl_centerY = scrollView.lhl_height * 0.5;
    if (imageView.lhl_height > LHLScreenH) {
        imageView.lhl_y = 0;
    }
    [scrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backBtn:)]];
    scrollView.contentSize = CGSizeMake(imageView.lhl_width, imageView.lhl_height);
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.image1] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!image) return;
        self.saveButton.enabled = YES;
    }];
    [scrollView addSubview:imageView];
    
    // 图片缩放
    CGFloat maxScale = self.topic.width / scrollView.lhl_width;
    if (maxScale > 1) {
        scrollView.maximumZoomScale = maxScale;
        scrollView.delegate = self;
    }
}

#pragma mark - 获得当前app的自定义相册
- (PHAssetCollection *)createdCollection{
    
    // 获得软件名字
    NSString *title = [NSBundle mainBundle].infoDictionary[(NSString *)kCFBundleNameKey];
    
    // 抓取所有自定义相册
    PHFetchResult<PHAssetCollection *> *collections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    // 查找当前app对应的自定义相册
    for (PHAssetCollection *collection in collections) {
        if ([collection.localizedTitle isEqualToString:title]) {
            return collection;
        }
    }
    
    /** 当前app的自定义相册没有被创建过 **/
    NSError *error = nil;
    __block NSString *createdCollectionID = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        // 2.创建自定义相册
        createdCollectionID = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:title].placeholderForCreatedAssetCollection.localIdentifier;
    } error:&error];
    
    if (error) return nil;
    
    // 根据唯一标示获得前面创建的相册
    PHAssetCollection *collection = [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[createdCollectionID] options:nil].firstObject;
    return collection;
    
}

#pragma mark - 监听点击
/**
 *  保存图片到相机胶卷
 */
- (IBAction)saveBtn:(id)sender {
    
    PHAuthorizationStatus oldStatus = [PHPhotoLibrary authorizationStatus];
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusDenied) { // 用户拒绝当前app访问相册
            if (oldStatus != PHAuthorizationStatusNotDetermined) {
                LHLLog(@"提醒用户打开开关");
            }
        }else if (status == PHAuthorizationStatusAuthorized){ // 用户允许当前app访问相册
            [self saveImageIntoAlbum];
        }else if (status == PHAuthorizationStatusRestricted){ // 无法访问相册
            [SVProgressHUD showErrorWithStatus:@"因系统原因，无法访问相册"];
        }
    }];
    
}
- (void)saveImageIntoAlbum
{
    //    1.保存图片到 相机胶卷
    NSError *error = nil;
    
    __block PHObjectPlaceholder *placeholder = nil;
    
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        placeholder = [PHAssetChangeRequest creationRequestForAssetFromImage:self.imageView.image].placeholderForCreatedAsset;
    } error:&error];
    if (!error) { // 保存成功
    }else{ // 保存失败
        [SVProgressHUD showErrorWithStatus:@"保存失败！"];
    }
    
    // 2.获得相册
    PHAssetCollection *createdCollection = self.createdCollection;
    if (createdCollection == nil) {
        [SVProgressHUD showErrorWithStatus:@"创建相册失败！"];
        return;
    }
    
    // 3.天加刚才创建的图片到自定义相册
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:createdCollection];
        //        [request addAssets:@[placeholder]];
        [request insertAssets:@[placeholder] atIndexes:[NSIndexSet indexSetWithIndex:0]];
        
        
    } error:&error];
    
    // 最后的判断
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"图片保存失败！"];
    }else{
        [SVProgressHUD showSuccessWithStatus:@"图片保存成功！"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    }
}

/**
 *  退出看图
 */
- (IBAction)backBtn:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - <UIScrollViewDelegate>
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    
    return self.imageView;
}
@end
