//
//  WKWebViewController.m
//  Coder_oc
//
//  Created by ddSoul on 17/2/8.
//  Copyright © 2017年 dxl. All rights reserved.
//

#import "WKWebViewController.h"
#import <WebKit/WebKit.h>

@interface WKWebViewController ()<WKUIDelegate,WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *wkWebView;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, assign) NSUInteger loadCount;

@end

@implementation WKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configeUI];
    // Do any additional setup after loading the view.
}

+ (void)load
{
    NSLog(@"________Load函数");
}

- (void)configeUI
{
    self.title = @"web";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [self.view addSubview:_wkWebView];
    
    _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 65, ScreenWidth, 2)];
    [self.view addSubview:_progressView];
    
    [_wkWebView addObserver:self
                     forKeyPath:@"estimatedProgress"
                        options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew
                        context:nil];
    [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"estimatedProgress"] && object == _wkWebView) {
        [self.progressView setAlpha:1.0f];
        [self.progressView setProgress:_wkWebView.estimatedProgress animated:YES];
        
        if(_wkWebView.estimatedProgress >= 1.0f)
        {
            [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0f animated:NO];
            }];
        }

    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)dealloc {
    [_wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
    
    // if you have set either WKWebView delegate also set these to nil here
    [_wkWebView setNavigationDelegate:nil];
    [_wkWebView setUIDelegate:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
