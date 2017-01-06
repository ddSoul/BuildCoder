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
    UIScrollView *lablesView = [[UIScrollView alloc] init];
    lablesView.frame = CGRectMake(0, 0, ScreenWidth, KHomeLabelsHeight);
    lablesView.contentSize = CGSizeMake(ScreenWidth * 2, 0);
    lablesView.showsHorizontalScrollIndicator = NO;
    [self addSubview:lablesView];
    
    for (int i = 0; i<10; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10 + i*100, 5, 80, 40)];
        btn.layer.cornerRadius = 5;
        btn.layer.borderColor = [UIColor redColor].CGColor;
        btn.layer.borderWidth = 1;
        [lablesView addSubview:btn];
    }
}

@end
