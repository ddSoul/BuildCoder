//
//  CoderLabelsManagerVC.m
//  Coder_oc
//
//  Created by ddSoul on 17/2/4.
//  Copyright © 2017年 dxl. All rights reserved.
//

#import "CoderLabelsManagerVC.h"
#import "ManagerLabelsCell.h"

@interface CoderLabelsManagerVC ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,CollectionGestureDelegate>

@property (nonatomic, strong) UICollectionView *colloectionView;

@property (nonatomic, strong) UIView *snapView;

@property (nonatomic, strong) NSIndexPath *preindexPath;

@property (nonatomic, strong) NSIndexPath *nextIndexPath;

@end

@implementation CoderLabelsManagerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.colloectionView];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UICollectionView *)colloectionView
{
    if (!_colloectionView) {
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        /**
         * 水平竖直最大的空间约束
         */
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        _colloectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, KNavgationItemHeight, ScreenWidth , ScreenHeight - KNavgationItemHeight) collectionViewLayout:flowLayout];
        [_colloectionView registerClass:[ManagerLabelsCell class] forCellWithReuseIdentifier:@"cell"];
        _colloectionView.backgroundColor = [UIColor whiteColor];
        _colloectionView.dataSource = self;
        _colloectionView.delegate = self;

    }
    return _colloectionView;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;

}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"cell";
    ManagerLabelsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    cell.delegate = self;
    if (!cell) {
        NSLog(@"无法创建");
    }
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(414*view_scal, 414*view_scal);
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0,0,0,0);
}

- (void)cellGestureAction:(UIGestureRecognizer *)gestureRecognizer
{
    //记录上一次手势的位置
    static CGPoint startPoint;
    //触发长按手势的cell
    ManagerLabelsCell * cell = (ManagerLabelsCell *)gestureRecognizer.view;

    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        NSLog(@"开始长按");
        
        NSArray *cells = [self.colloectionView visibleCells];
        for (ManagerLabelsCell *cell in cells) {
            [cell showDeleteButton];
        }
        
        //获取cell的截图
        _snapView  = [cell snapshotViewAfterScreenUpdates:YES];
        _snapView.center = cell.center;
        [_colloectionView addSubview:_snapView];
        _preindexPath = [_colloectionView indexPathForCell:cell];
        startPoint = [gestureRecognizer locationInView:_colloectionView];

    }else if(gestureRecognizer.state == UIGestureRecognizerStateChanged){
        NSLog(@"开始移动");
        
        CGFloat tranX = [gestureRecognizer locationOfTouch:0 inView:_colloectionView].x - startPoint.x;
        CGFloat tranY = [gestureRecognizer locationOfTouch:0 inView:_colloectionView].y - startPoint.y;

        
        NSLog(@"__________%f___________%f",tranX,tranY);
        //设置截图视图位置
//        _snapView.center = CGPointApplyAffineTransform(_snapView.center, CGAffineTransformMakeTranslation(tranX, tranY));
        _snapView.center = CGPointMake(_snapView.centerX + tranX, _snapView.centerY + tranY);
        
        startPoint = [gestureRecognizer locationOfTouch:0 inView:_snapView];
        
        
        //计算截图视图和哪个cell相交
        for (UICollectionViewCell *cell in [_colloectionView visibleCells]) {
            //跳过隐藏的cell
            if ([_colloectionView indexPathForCell:cell] == _preindexPath || [[_colloectionView indexPathForCell:cell] item] == 0) {
                continue;
            }
            //计算中心距
            CGFloat space = sqrtf(pow(_snapView.center.x - cell.center.x, 2) + powf(_snapView.center.y - cell.center.y, 2));
            
            //如果相交一半且两个视图Y的绝对值小于高度的一半就移动
            if (space <= _snapView.bounds.size.width * 0.5 && (fabs(_snapView.center.y - cell.center.y) <= _snapView.bounds.size.height * 0.5)) {
                _nextIndexPath = [_colloectionView indexPathForCell:cell];
                if (_nextIndexPath.item > _preindexPath.item) {
                    for (NSUInteger i = _preindexPath.item; i < _nextIndexPath.item ; i ++) {
//                        [[YLDragSortTool shareInstance].subscribeArray exchangeObjectAtIndex:i withObjectAtIndex:i + 1];
                    }
                }else{
                    for (NSUInteger i = _preindexPath.item; i > _nextIndexPath.item ; i --) {
//                        [[YLDragSortTool shareInstance].subscribeArray exchangeObjectAtIndex:i withObjectAtIndex:i - 1];
                    }
                }
//                //移动
//                [_colloectionView moveItemAtIndexPath:_preindexPath toIndexPath:_nextIndexPath];
////                //设置移动后的起始indexPath
//                _preindexPath = _nextIndexPath;
                break;
            }
        }
        
    }else if(gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        
        //                //移动
        [_colloectionView moveItemAtIndexPath:_preindexPath toIndexPath:_nextIndexPath];
        //                //设置移动后的起始indexPath
        _preindexPath = _nextIndexPath;
        NSLog(@"____滑动结束");
        [_snapView removeFromSuperview];
    
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
