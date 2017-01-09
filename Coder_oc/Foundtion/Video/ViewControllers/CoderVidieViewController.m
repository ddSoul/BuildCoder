//
//  CoderVidieViewController.m
//  Coder_oc
//
//  Created by ddSoul on 17/1/6.
//  Copyright © 2017年 dxl. All rights reserved.
//

#import "CoderVidieViewController.h"
#import "HomeLabelViews.h"
#import "VedioCell.h"

@interface CoderVidieViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *vedioList;

@property (nonatomic, strong) WMPlayer *wmPlayer;

@end

@implementation CoderVidieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self configeVideoNavgationItem];
    // Do any additional setup after loading the view.
}

- (void)initUI
{
    self.vedioList = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.vedioList.delegate = self;
    self.vedioList.dataSource = self;
    [self.vedioList registerNib:[UINib nibWithNibName:@"VedioCell" bundle:nil] forCellReuseIdentifier:@"vediecell"];
    [self.view addSubview:self.vedioList];
}

- (void)configeVideoNavgationItem
{
    self.title = @"";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    HomeLabelViews *navLabels = [[HomeLabelViews alloc] initWithFrame:CGRectMake(0, 20, ScreenWidth, 44)];
    self.navigationItem.titleView = navLabels;
}

#pragma mark - tableViewDelegate,dataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 189;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VedioCell *cell = [tableView dequeueReusableCellWithIdentifier:@"vediecell"
                                                         forIndexPath:indexPath];
    
    __weak typeof(cell) weakCell = cell;
    cell.vedioPlay = ^(){
        [weakCell.contentView addSubview:self.wmPlayer];
        [self.wmPlayer play];
    };
    return cell;
}

- (WMPlayer *)wmPlayer
{
    if (!_wmPlayer) {
        //        _wmPlayer = [[WMPlayer alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) videoURLStr:[NSURL URLWithString:@""]];
        _wmPlayer = [[WMPlayer alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
        _wmPlayer.URLString = @"http://flv2.bn.netease.com/videolib3/1701/01/diFGq4703/SD/diFGq4703-mobile.mp4";
        _wmPlayer.closeBtn.hidden = YES;
    }
    return _wmPlayer;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
