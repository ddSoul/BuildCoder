//
//  HomeLabelViews.m
//  Coder_oc
//
//  Created by ddSoul on 17/1/6.
//  Copyright © 2017年 dxl. All rights reserved.
//

#import "HomeLabelViews.h"

@implementation HomeLabelViews


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.frame = frame;
        [self createControls];
    }
    return self;
}

/**
 * 创建控件
 */
- (void)createControls
{
    self.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
    
    UIScrollView *lablesView = [[UIScrollView alloc] init];
    lablesView.frame = CGRectMake(0, 0, ScreenWidth, KHomeLabelsHeight);
    lablesView.contentSize = CGSizeMake(ScreenWidth * 2, 0);
    lablesView.showsHorizontalScrollIndicator = NO;
    [self addSubview:lablesView];
    
    for (int i = 0; i<10; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10 + i*80, 5, 60, 40)];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:@"推荐" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:17];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [lablesView addSubview:btn];
        
        if (i == 0) {
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
    }
    
    UIButton *managerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    managerButton.backgroundColor = [UIColor grayColor];
    [managerButton addTarget:self.delegate action:@selector(managerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:managerButton];
    
    [managerButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.right.bottom.mas_equalTo(0);
        make.width.mas_equalTo(60);
    }];
}

//- (void)managerClick:(UIButton *)button
//{
//    NSLog(@"____管理点击了");
//}

@end
