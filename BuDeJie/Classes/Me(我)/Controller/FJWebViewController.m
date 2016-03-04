//
//  FJWebViewController.m
//  BuDeJie
//
//  Created by Francis on 16/2/22.
//  Copyright © 2016年 FRAJ. All rights reserved.
//

#import "FJWebViewController.h"
#import <WebKit/WebKit.h>

@interface FJWebViewController ()
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (nonatomic ,weak) WKWebView *webVeiw;
@property (weak, nonatomic) IBOutlet UIProgressView *progressVeiw;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardButton;

@end

@implementation FJWebViewController
- (IBAction)goBackButtonClick:(id)sender {
    [_webVeiw goBack];
}
- (IBAction)goForwardButtonClick:(id)sender {
    [_webVeiw goForward];
}
- (IBAction)refreshButtonClick:(id)sender {
    [_webVeiw reload];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    WKWebView *webView = [[WKWebView alloc] init];
    _webVeiw = webView;
    
    
    [_contentView addSubview:webView];
    
    //显示网页
    NSURLRequest *request = [NSURLRequest requestWithURL:_url];
//    FJLog(@"%@",_url);
    [webView loadRequest:request];
    
    //KVO监听属性
    [webView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"canGoForward" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    
    
    
}

//使用KVO添加监听,监听结束后必须移除观察者
-(void)dealloc{
    [_webVeiw removeObserver:self forKeyPath:@"canGoBack"];
    [_webVeiw removeObserver:self forKeyPath:@"canGoForward"];
    [_webVeiw removeObserver:self forKeyPath:@"estimatedProgress"];
    [_webVeiw removeObserver:self forKeyPath:@"title"];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    _backButton.enabled = _webVeiw.canGoBack;
    _forwardButton.enabled = _webVeiw.canGoForward;
    
    _progressVeiw.progress = _webVeiw.estimatedProgress;
    _progressVeiw.hidden = _webVeiw.estimatedProgress >= 1;
    
    
    self.title = _webVeiw.title;
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    //设置webView的尺寸
    //1.获取webView对象
    WKWebView *webView = self.contentView.subviews[0];
    webView.frame = self.contentView.bounds;
}

@end
