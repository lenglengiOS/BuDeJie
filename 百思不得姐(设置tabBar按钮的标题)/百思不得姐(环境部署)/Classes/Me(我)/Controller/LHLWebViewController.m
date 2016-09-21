//
//  LHLWebViewController.m
//  百思不得姐(环境部署)
//
//  Created by admin on 16/9/17.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "LHLWebViewController.h"
#import <WebKit/WebKit.h>

@interface LHLWebViewController ()
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (nonatomic, weak) WKWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backIem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardItem;
@property (weak, nonatomic) IBOutlet UIProgressView *progressItem;

@end

@implementation LHLWebViewController

- (IBAction)goBack:(id)sender {
    [self.webView goBack];
}
- (IBAction)goForward:(id)sender {
    [self.webView goForward];
}
- (IBAction)reload:(id)sender {
    [self.webView reload];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // 添加webView
    WKWebView *webView = [[WKWebView alloc] init];
    webView.frame = self.containerView.bounds;
    _webView = webView;
    
    [self.containerView addSubview:webView];
    
    // 展示网页
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_url]];
    [webView loadRequest:request];
    
    // 前进 后退 刷新 进度条
    
    [webView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"canGoForward" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
}

// KVO 监听 前进 后退 进度条 的值来确定状态
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{

    self.backIem.enabled = self.webView.canGoBack;
    self.forwardItem.enabled = self.webView.canGoForward;
    self.progressItem.progress = self.webView.estimatedProgress;
    self.progressItem.hidden = self.webView.estimatedProgress >= 1;
    
    
}

// 移除监听
- (void)dealloc{
    [self.webView removeObserver:self forKeyPath:@"canGoBack"];
    [self.webView removeObserver:self forKeyPath:@"canGoForward"];
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    
}


- (void)viewDidLayoutSubviews{
    
    _webView.frame = self.containerView.bounds;
}



@end
