//
//  ManagerLabelsCell.m
//  Coder_oc
//
//  Created by ddSoul on 17/2/4.
//  Copyright © 2017年 dxl. All rights reserved.
//

#import "ManagerLabelsCell.h"

@interface ManagerLabelsCell ()<UIGestureRecognizerDelegate>
{
    UIImageView *_delImageView;
}
@end

@implementation ManagerLabelsCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createViews];
    }
    return self;
}

- (void)createViews {
    
    //给每个cell添加一个长按手势
    UILongPressGestureRecognizer * longPress =[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(gestureAction:)];
    longPress.delegate = self;
    [self addGestureRecognizer:longPress];
    
    UIPanGestureRecognizer * pan =[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(gestureAction:)];
    pan.delegate = self;
    [self addGestureRecognizer:pan];
    
    
    UIImageView *_cellBackImageView = [[UIImageView alloc] init];
    _cellBackImageView.image = [UIImage imageNamed:@"share_icon"];
    [self.contentView addSubview:_cellBackImageView];
    
    [_cellBackImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
    
    _delImageView = [[UIImageView alloc] init];
    _delImageView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:_delImageView];
    
    [_delImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(0);
        make.width.height.mas_equalTo(20);
    }];
    
    

}

//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
//    
//    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && ![YLDragSortTool shareInstance].isEditing) {
//        return NO;
//    }
//    return YES;
//}
- (void)showDeleteButton
{
    _delImageView.backgroundColor = [UIColor orangeColor];
}

- (void)gestureAction:(UIGestureRecognizer *)gestureRecognizer{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(cellGestureAction:)]) {
        [self.delegate cellGestureAction:gestureRecognizer];
    }

}

@end
