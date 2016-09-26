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
@end

@implementation LHLSeeBigPictureViewController

/**
 *  保存图片到相机胶卷
 */
- (IBAction)saveBtn:(id)sender {
//    NSError *error = nil;
////    1.保存图片到 相机胶卷
//    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
//        [PHAssetChangeRequest creationRequestForAssetFromImage:self.imageView.image];
//    } error:&error];
//    if (!error) { // 保存成功
//        [SVProgressHUD showSuccessWithStatus:@"保存成功！"];
//    }else{ // 保存失败
//        [SVProgressHUD showErrorWithStatus:@"保存失败！"];
//    }
    
    // 获得软件名字
    NSString *title = [NSBundle mainBundle].infoDictionary[(NSString *)kCFBundleNameKey];
    
    // 抓取所有自定义相册
    PHFetchResult<PHAssetCollection *> *collections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    // 查找当前app对应的自定义相册
    PHAssetCollection *createdCollection = nil;
    for (PHAssetCollection *collection in collections) {
        if ([collection.localizedTitle isEqualToString:title]) {
            createdCollection = collection;
            break;
        }
    }
    
    // 当前app的自定义相册没有被创建过
    if (createdCollection == nil) {
        NSError *error = nil;
        NSString *title = [NSBundle mainBundle].infoDictionary[(NSString *)kCFBundleNameKey];
        __block NSString *createdCollectionID = nil;
        [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
            // 2.创建自定义相册
            createdCollectionID = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:title].placeholderForCreatedAssetCollection.localIdentifier;
        } error:&error];
        createdCollection = [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[createdCollectionID] options:nil].firstObject;
    }
    
    LHLLog(@"%@", createdCollection);
}

/**
 *  退出看图
 */
- (IBAction)backBtn:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

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

#pragma mark - <UIScrollViewDelegate>
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    
    return self.imageView;
}
@end
