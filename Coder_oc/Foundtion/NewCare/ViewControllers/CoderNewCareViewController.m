//
//  CoderNewCareViewController.m
//  Coder_oc
//
//  Created by ddSoul on 17/1/6.
//  Copyright © 2017年 dxl. All rights reserved.
//

#import "CoderNewCareViewController.h"
#import "MineHeaderView.h"

@interface CoderNewCareViewController ()

@property (nonatomic, strong) MineHeaderView *headerViews;

@end

@implementation CoderNewCareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的关注";
    [self.view addSubview:self.headerViews];
    // Do any additional setup after loading the view.
}

- (MineHeaderView *)headerViews
{
    if (!_headerViews) {
        _headerViews = [[MineHeaderView alloc] initWithFrame:CGRectMake(0, 100, ScreenWidth, 100)];
    }
    return _headerViews;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
