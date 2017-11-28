//
//  CoderHomeViewController.m
//  Coder_oc
//
//  Created by ddSoul on 17/1/3.
//  Copyright © 2017年 dxl. All rights reserved.
//
#import "CoderHomeViewController.h"
#import "CoderSearchViewController.h"
#import "CoderLabelsManagerVC.h"

#import "XLRefreshHeader.h"
#import "ShareAlertViews.h"
#import "SmallImageCell.h"
#import "HomeLabelViews.h"
#import "BigImageCell.h"
#import "TextCell.h"

#import "News.h"

@interface  CoderHomeViewController()<UITableViewDelegate,UITableViewDataSource,ManageButtonClickDelegte>

@property (nonatomic, strong) HomeLabelViews *labelsView;
@property (nonatomic, strong) UITableView *newslist;
@property (nonatomic, strong) NSMutableArray *newsDataArray;

@end

@implementation CoderHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self requestData];
//    [self addRunloopObserver];
    // Do any additional setup after loading the view.
}

- (void)initUI {
    
    [self configeHomeNavgationItem];
    [self.view addSubview:self.labelsView];
    [self.view addSubview:self.newslist];
    /**20170921 暂时修改iOS11 titleView显示问题*/
    YYFPSLabel *fpsLabel = [[YYFPSLabel alloc] initWithFrame:CGRectMake(10, 200, 80, 30)];
    [self.view addSubview:fpsLabel];
//    self.navigationItem.titleView = fpsLabel;
    
    [self.newslist addRefreshHeaderWithHandle:^{
        NSLog(@"kaishi刷新了");
    }];
}

#pragma mark - private Metheds
- (void)requestData {
    //假数据
    NSArray *tempArray = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"newsData.plist" ofType:nil]];

    for (NSDictionary *value in tempArray) {
        News *newModel = [News mj_objectWithKeyValues:value];
        [self.newsDataArray addObject:newModel];
    }
    [_newslist reloadData];
}
- (void)toSearchVc {
    CoderSearchViewController *searchVc = [[CoderSearchViewController alloc] init];
    searchVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchVc animated:YES];
}
//MARK: - 回调函数
//定义一个回调函数  一次RunLoop来一次
static void Callback(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info){
    NSLog(@"______________Runloop 走一波");
}
//这里面都是C语言 -- 添加一个监听者
-(void)addRunloopObserver{
    //获取当前的RunLoop
    CFRunLoopRef runloop = CFRunLoopGetCurrent();
    //定义一个centext
    CFRunLoopObserverContext context = {
        0,
        ( __bridge void *)(self),
        &CFRetain,
        &CFRelease,
        NULL
    };
    //定义一个观察者
    static CFRunLoopObserverRef defaultModeObsever;
    //创建观察者
    defaultModeObsever = CFRunLoopObserverCreate(NULL,
                                                 kCFRunLoopBeforeWaiting,
                                                 YES,
                                                 NSIntegerMax - 999,
                                                 &Callback,
                                                 &context
                                                 );
    
    //添加当前RunLoop的观察者
    CFRunLoopAddObserver(runloop, defaultModeObsever, kCFRunLoopDefaultMode);
    //c语言有creat 就需要release
    CFRelease(defaultModeObsever);
    
}


#pragma mark - delegate Metheds
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
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"---run---%@",[NSRunLoop currentRunLoop].currentMode);
}

#pragma mark - TouchEvent Metheds
- (void)managerButtonClick:(UIButton *)button {
    CoderLabelsManagerVC *labelsManagerVC = [[CoderLabelsManagerVC alloc] init];
    [self presentViewController:labelsManagerVC animated:YES completion:nil];
}

#pragma mark - Setter、Getter
- (NSMutableArray *)newsDataArray {
    if (!_newsDataArray) {
        _newsDataArray = @[].mutableCopy;
    }
    return _newsDataArray;
}
- (HomeLabelViews *)labelsView {
    if (!_labelsView) {
        _labelsView = [[HomeLabelViews alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, KHomeLabelsHeight)];
        _labelsView.delegate = self;
    }
    return _labelsView;
}
- (UITableView *)newslist {
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
