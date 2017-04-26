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
#import "VedioNews.h"

@interface CoderVidieViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *vedioList;
@property (nonatomic, strong) WMPlayer *wmPlayer;

@property (nonatomic, strong) NSMutableArray *newsDataArray;

@end

@implementation CoderVidieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self configeVideoNavgationItem];
    [self requestVedioNesData];
    // Do any additional setup after loading the view.
}

- (void)initUI
{
    self.vedioList = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - KNavgationItemHeight)];
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

- (void)requestVedioNesData
{
    //假数据
    NSArray *tempArray = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"VedioData.plist" ofType:nil]];
    
    for (NSDictionary *value in tempArray) {
        VedioNews *newModel = [VedioNews mj_objectWithKeyValues:value];
        [self.newsDataArray addObject:newModel];
    }
    [_vedioList reloadData];

}

#pragma mark - tableViewDelegate,dataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 189;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.newsDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VedioCell *cell = [tableView dequeueReusableCellWithIdentifier:@"vediecell"
                                                         forIndexPath:indexPath];
    
    __weak typeof(cell) weakCell = cell;
    __weak typeof (self) weakSelf = self;
    
    cell.vedioPlay = ^(NSString *vedioUrl){
        [weakCell.contentView addSubview:weakSelf.wmPlayer];
        weakSelf.wmPlayer.URLString = vedioUrl;
        [weakSelf.wmPlayer play];
    };
    cell.model = self.newsDataArray[indexPath.row];
    return cell;
}

- (NSMutableArray *)newsDataArray
{
    if (!_newsDataArray) {
        _newsDataArray = @[].mutableCopy;
    }
    return _newsDataArray;
}

- (WMPlayer *)wmPlayer
{
    if (!_wmPlayer) {
        _wmPlayer = [[WMPlayer alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 147)];
        _wmPlayer.closeBtn.hidden = YES;
    }
    return _wmPlayer;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
