//
//  CoderHomeViewController.m
//  Coder_oc
//
//  Created by ddSoul on 17/1/3.
//  Copyright © 2017年 dxl. All rights reserved.
//

#import "CoderHomeViewController.h"
#import "CoderSearchViewController.h"
#import "HomeLabelViews.h"
#import "BigImageCell.h"
#import "SmallImageCell.h"
#import "TextCell.h"
#import "News.h"
#import "XLRefreshHeader.h"
#import "CoderLabelsManagerVC.h"
#import "ShareAlertViews.h"

@interface CoderHomeViewController ()<UITableViewDelegate,UITableViewDataSource,ManageButtonClickDelegte>

@property (nonatomic, strong) HomeLabelViews *labelsView;

@property (nonatomic, strong) UITableView *newslist;

@property (nonatomic, strong) NSMutableArray *newsDataArray;


@end

@implementation CoderHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self requestData];
    // Do any additional setup after loading the view.
}

- (void)initUI{
    
    [self configeHomeNavgationItem];
    [self.view addSubview:self.labelsView];
    [self.view addSubview:self.newslist];
    
    YYFPSLabel *fpsLabel = [[YYFPSLabel alloc] initWithFrame:CGRectMake(10, 60, 80, 30)];
    
    self.navigationItem.titleView = fpsLabel;
    
    [self.newslist addRefreshHeaderWithHandle:^{
        NSLog(@"kaishi刷新了");
    }];
}

#pragma mark - 数据
- (void)requestData
{
    //假数据
    NSArray *tempArray = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"newsData.plist" ofType:nil]];

    for (NSDictionary *value in tempArray) {
        News *newModel = [News mj_objectWithKeyValues:value];
        [self.newsDataArray addObject:newModel];
    }
    [_newslist reloadData];
}

- (NSMutableArray *)newsDataArray
{
    if (!_newsDataArray) {
        _newsDataArray = @[].mutableCopy;
    }
    return _newsDataArray;
}

- (HomeLabelViews *)labelsView
{
    if (!_labelsView) {
        _labelsView = [[HomeLabelViews alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, KHomeLabelsHeight)];
        _labelsView.delegate = self;
    }
    return _labelsView;
}

- (UITableView *)newslist
{
    if (!_newslist) {
        _newslist = [[UITableView alloc] initWithFrame:CGRectMake(0, KHomeLabelsHeight, ScreenWidth, ScreenHeight - KHomeLabelsHeight - KNavgationItemHeight - KTabbarItemHeight)];
        _newslist.delegate = self;
        _newslist.dataSource = self;
        _newslist.showsVerticalScrollIndicator = NO;

        [_newslist registerClass:[BigImageCell class] forCellReuseIdentifier:@"bigImage"];
        [_newslist registerClass:[SmallImageCell class] forCellReuseIdentifier:@"smallImage"];
        [_newslist registerClass:[TextCell class] forCellReuseIdentifier:@"textCell"];
    }
    return _newslist;
}


/**
 * height
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.newsDataArray.count) {
        return 10;
    }
    
    News *newsModel = [News new];
    newsModel = self.newsDataArray[indexPath.row];
    HomeCellType cellType = newsModel.type;
    
    if (cellType == bigImageType) {
        return [tableView fd_heightForCellWithIdentifier:@"bigImage" configuration:^(BigImageCell *cell) {
            cell.model = newsModel;
        }];
    }
    
    if (cellType == smallImageType) {
        return [tableView fd_heightForCellWithIdentifier:@"smallImage" configuration:^(SmallImageCell *cell) {
            cell.model = newsModel;
        }];

    }
    
    return [tableView fd_heightForCellWithIdentifier:@"textCell" configuration:^(TextCell *cell) {
        
            cell.model = newsModel;
    }];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.newsDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //count==0,returen
    if (!self.newsDataArray.count) {
        BigImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bigImage" forIndexPath:indexPath];
        return cell;
    }
    
    //三种cell
    News *newsModel = [News new];
    newsModel = self.newsDataArray[indexPath.row];
    HomeCellType cellType = newsModel.type;
    
    if (cellType == bigImageType) {
        BigImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bigImage" forIndexPath:indexPath];
        cell.model = newsModel;
        cell.footerViews.shareButtonClick = ^(UIButton *button){

            CGPoint point = [button convertPoint:button.center fromView:self.view];
            ShareAlertViews *alertViews = [[ShareAlertViews alloc] initAlertViewsWithHeight:-point.y];
            [self.view addSubview:alertViews];
            button.backgroundColor = [UIColor orangeColor];
        };
        return cell;
    }
    
    if (cellType == smallImageType) {
        SmallImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"smallImage" forIndexPath:indexPath];
        cell.model = newsModel;
        return cell;
    }
    
    BigImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"textCell" forIndexPath:indexPath];
    cell.model = newsModel;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.newslist.header endRefreshing];
    WKWebViewController *wkwebViewController = [[WKWebViewController alloc] init];
    wkwebViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:wkwebViewController animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSLog(@"---run---%@",[NSRunLoop currentRunLoop].currentMode);
}

- (void)toSearchVc
{
    CoderSearchViewController *searchVc = [[CoderSearchViewController alloc] init];
    searchVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchVc animated:YES];
}

- (void)managerButtonClick:(UIButton *)button
{
    CoderLabelsManagerVC *labelsManagerVC = [[CoderLabelsManagerVC alloc] init];
    [self presentViewController:labelsManagerVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
