//
//  CoderMineViewController.m
//  Coder_oc
//
//  Created by ddSoul on 17/1/3.
//  Copyright © 2017年 dxl. All rights reserved.
//

#import "CoderMineViewController.h"
#import "CoderLoginViewController.h"
#import "Mine.h"
#import "MineInfoCell.h"
#import "MineHeaderView.h"

#define KCellID @"mineinfoCell"

@interface CoderMineViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) MineHeaderView *haderViews;

@end

@implementation CoderMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI
{
    self.title = @"个人中心";
    
    UITableView *mineInfoTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    mineInfoTableView.delegate = self;
    mineInfoTableView.dataSource = self;
    [mineInfoTableView registerNib:[UINib nibWithNibName:@"MineInfoCell" bundle:nil] forCellReuseIdentifier:KCellID];
    [self.view addSubview:mineInfoTableView];
    
}

#pragma mark - tableViewDelegate,dataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 100;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    self.haderViews = [[MineHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
    return self.haderViews;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MineInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellID
                                                    forIndexPath:indexPath];
    return cell;
}
//下拉放大headerView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat yOffset = scrollView.contentOffset.y;
    
    if (yOffset < -64) {
        CGFloat totalOffset = 100 + ABS(yOffset);
        CGFloat f = totalOffset / 100;
        self.haderViews.avtorImageView_b.frame = CGRectMake(- (width *f-width) / 2, yOffset+64, width * f, totalOffset-64);
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CATransition *transition=[[CATransition alloc] init];
    transition.type = @"rippleEffect";
    //设置动画时常
    transition.duration=1.0f;
    [self.view.window.layer addAnimation:transition forKey:@"KCTransitionAnimation1"];
    
    CoderLoginViewController *push = [[CoderLoginViewController alloc] init];
    push.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:push animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
