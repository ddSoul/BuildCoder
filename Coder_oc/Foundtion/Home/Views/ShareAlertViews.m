//
//  ShareAlertViews.m
//  Coder_oc
//
//  Created by ddSoul on 17/2/8.
//  Copyright © 2017年 dxl. All rights reserved.
//

#import "ShareAlertViews.h"

@interface ShareAlertViews ()
{
    UIView *_mview;
}

@end

@implementation ShareAlertViews

//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if(self)
//    {
//        self.frame = frame;
//        [self createControls];
//    }
//    return self;
//}

- (id)initAlertViewsWithHeight:(CGFloat)height
{
    self = [super init];
    if(self)
    {
        [self createControls:height];
    }
    return self;

}

/**
 * 创建控件
 */
- (void)createControls:(CGFloat)height
{
    _mview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth,ScreenHeight)];
    _mview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    [[UIApplication sharedApplication].keyWindow addSubview:_mview];
    
    UIButton *_closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _closeButton.backgroundColor = [UIColor whiteColor];
    [_closeButton addTarget:self action:@selector(removeView) forControlEvents:UIControlEventTouchUpInside];
    [_mview addSubview:_closeButton];
    
    [_closeButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(height-20);
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.height.mas_equalTo(100);
    }];
    
    [UIView animateWithDuration:0.8f animations:^{
        
        [_closeButton layoutIfNeeded];//强制绘制

    }];
}

- (void)removeView
{
    [_mview removeFromSuperview];
}

@end
